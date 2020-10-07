import sys

from problem_spec import ProblemSpec
from robot_config import write_robot_config_list_to_file
from tester import test_config_equality
from tester import test_environment_bounds
from tester import test_angle_constraints
from tester import test_length_constraints
from tester import test_grapple_point_constraint
from tester import test_self_collision
from tester import test_config_distance
from tester import test_obstacle_collision
from tester import test_grapple_commonality
from tester import point_is_close
# from visualiser import Visualiser
from angle import Angle
from robot_config import make_robot_config_from_ee1
from robot_config import make_robot_config_from_ee2
import random
import math
import time


"""
Template file for you to implement your solution to Assignment 2. Contains a class you can use to represent graph nodes,
and a method for finding a path in a graph made up of GraphNode objects.

COMP3702 2020 Assignment 2 Support Code
"""

SAMPLE_SIZE = 50
DIST_THRESHOLD = 1
PATH_CHECK_STEP = 1
NUM_BRIDGES = 5


class GraphNode:
    """
    Class representing a node in the state graph. You should create an instance of this class each time you generate
    a sample.
    """

    def __init__(self, spec, config):
        """
        Create a new graph node object for the given config.

        Neighbors should be added by appending to self.neighbors after creating each new GraphNode.

        :param spec: ProblemSpec object
        :param config: the RobotConfig object to be stored in this node
        """
        self.spec = spec
        self.config = config
        self.neighbors = []

    def __eq__(self, other):
        return test_config_equality(self.config, other.config, self.spec)

    def __hash__(self):
        return hash(tuple(self.config.points))

    def get_successors(self):
        return self.neighbors

    @staticmethod
    def add_connection(n1, n2):
        """
        Creates a neighbor connection between the 2 given GraphNode objects.

        :param n1: a GraphNode object
        :param n2: a GraphNode object
        """
        n1.neighbors.append(n2)
        n2.neighbors.append(n1)


def find_graph_path(spec, init_node):
    """
    This method performs a breadth first search of the state graph and return a list of configs which form a path
    through the state graph between the initial and the goal. Note that this path will not satisfy the primitive step
    requirement - you will need to interpolate between the configs in the returned list.

    You may use this method in your solver if you wish, or can implement your own graph search algorithm to improve
    performance.

    :param spec: ProblemSpec object
    :param init_node: GraphNode object for the initial configuration
    :return: List of configs forming a path through the graph from initial to goal
    """
    # search the graph
    init_container = [init_node]

    # here, each key is a graph node, each value is the list of configs visited on the path to the graph node
    init_visited = {init_node: [init_node.config]}

    while len(init_container) > 0:
        current = init_container.pop(0)

        if test_config_equality(current.config, spec.goal, spec):
            # found path to goal
            return init_visited[current]

        successors = current.get_successors()
        for suc in successors:
            if suc not in init_visited:
                init_container.append(suc)
                init_visited[suc] = init_visited[current] + [suc.config]

    return None


def detect_collision(spec, config):
    if test_environment_bounds(config) and test_angle_constraints(config, spec) and \
            test_length_constraints(config, spec) and test_grapple_point_constraint(config, spec) and \
            test_self_collision(config, spec) and test_obstacle_collision(config, spec, spec.obstacles):
        return True
    else:
        return False


def generate_sample(spec, config, index):
    angles = []
    lengths = []
    for i in range(spec.num_segments):
        angles.append(Angle(random.uniform(-165, 165)))
        if spec.min_lengths != spec.max_lengths:
            lengths.append(random.uniform(spec.min_lengths[i], spec.max_lengths[i]))
        else:
            lengths = config.lengths
    if index % 2 == 0:
        next_config = make_robot_config_from_ee1(spec.grapple_points[index][0], spec.grapple_points[index][1], angles,
                                                 lengths, ee1_grappled=True, ee2_grappled=False)
    else:
        next_config = make_robot_config_from_ee2(spec.grapple_points[index][0], spec.grapple_points[index][1], angles,
                                                 lengths, ee1_grappled=False, ee2_grappled=True)
    if detect_collision(spec, next_config):
        node = GraphNode(spec, next_config)
        return node
    else:
        return generate_sample(spec, config, index)


def bridge_config(spec, config, index):
    angles = []
    lengths = []
    for i in range(spec.num_segments - 1):
        angles.append(Angle(degrees=random.uniform(-165, 165)))
        if spec.min_lengths != spec.max_lengths:
            lengths.append(random.uniform(spec.min_lengths[i], spec.max_lengths[i]))
        else:
            lengths = config.lengths[:-1]
    if index % 2 == 0:
        next_config = make_robot_config_from_ee1(spec.grapple_points[index][0], spec.grapple_points[index][1], angles,
                                                 lengths, ee1_grappled=True, ee2_grappled=False)
        last_point = next_config.points[-1]
    else:
        next_config = make_robot_config_from_ee2(spec.grapple_points[index][0], spec.grapple_points[index][1], angles,
                                                 lengths, ee1_grappled=False, ee2_grappled=True)
        last_point = next_config.points[0]

    delta_x = spec.grapple_points[index + 1][0] - last_point[0]
    delta_y = spec.grapple_points[index + 1][1] - last_point[1]
    last_length = (delta_x**2 + delta_y**2)**0.5
    if delta_x == 0:
        if delta_y > 0:
            last_angle = math.pi / 2
        else:
            last_angle = -math.pi / 2
    elif delta_x > 0:
        last_angle = math.atan(delta_y / delta_x)
    else:
        last_angle = math.atan(delta_y / delta_x) + math.pi
    last_angle = Angle(last_angle)
    for angle in angles:
        last_angle -= angle
    angles.append(last_angle)
    if index % 2 == 0:
        lengths.append(last_length)
    else:
        lengths.insert(0, last_length)
    if index % 2 == 0:
        final_config = make_robot_config_from_ee1(spec.grapple_points[index][0], spec.grapple_points[index][1], angles,
                                                  lengths, ee1_grappled=True, ee2_grappled=True)
    else:
        final_config = make_robot_config_from_ee2(spec.grapple_points[index][0], spec.grapple_points[index][1], angles,
                                                  lengths, ee1_grappled=True, ee2_grappled=True)
    if detect_collision(spec, final_config):
        return GraphNode(spec, final_config)
    else:
        return bridge_config(spec, config, index)


def dist(c1, c2, spec):
    max_ee1_delta = 0
    max_ee2_delta = 0
    for i in range(spec.num_segments):
        if abs((c2.ee1_angles[i] - c1.ee1_angles[i]).in_radians()) > max_ee1_delta:
            max_ee1_delta = abs((c2.ee1_angles[i] - c1.ee1_angles[i]).in_radians())
        if abs((c2.ee2_angles[i] - c1.ee2_angles[i]).in_radians()) > max_ee2_delta:
            max_ee2_delta = abs((c2.ee2_angles[i] - c1.ee2_angles[i]).in_radians())
    max_delta = min(max_ee1_delta, max_ee2_delta)
    for i in range(spec.num_segments):
        if abs(c2.lengths[i] - c1.lengths[i]) > max_delta:
            max_delta = abs(c2.lengths[i] - c1.lengths[i])
    # measure leniently - allow compliance from EE1 or EE2
    return max_delta


def interpolation_path(c1, c2, spec):
    max_delta = dist(c1, c2, spec)
    n_steps = math.ceil(max_delta / 0.001)
    path = [c1]
    for i in range(1, n_steps):
        angles = []
        lengths = []
        if c1.ee1_grappled and c2.ee1_grappled:
            for j in range(spec.num_segments):
                angles.append((c2.ee1_angles[j] - c1.ee1_angles[j]).in_radians() * i / n_steps + c1.ee1_angles[j])
                lengths.append((c2.lengths[j] - c1.lengths[j]) * i / n_steps + c1.lengths[j])
            next_config = make_robot_config_from_ee1(c1.get_ee1()[0], c1.get_ee1()[1], angles, lengths,
                                                     ee1_grappled=True, ee2_grappled=False)
        else:
            for j in range(spec.num_segments):
                angles.append((c2.ee2_angles[j] - c1.ee2_angles[j]).in_radians() * i / n_steps + c1.ee2_angles[j])
                lengths.append((c2.lengths[j] - c1.lengths[j]) * i / n_steps + c1.lengths[j])
            next_config = make_robot_config_from_ee2(c1.get_ee2()[0], c1.get_ee2()[1], angles, lengths,
                                                     ee1_grappled=False, ee2_grappled=True)
        if i % PATH_CHECK_STEP == 0:
            if detect_collision(spec, next_config):
                path.append(next_config)
            else:
                return False
        else:
            path.append(next_config)
    path.append(c2)
    return path


def main(arglist):
    sys.setrecursionlimit(5000)
    # print(sys.getrecursionlimit())
    # t_start = time.time()
    input_file = arglist[0]
    output_file = arglist[1]

    spec = ProblemSpec(input_file)

    init_node = GraphNode(spec, spec.initial)
    goal_node = GraphNode(spec, spec.goal)

    steps = []

    #
    #
    # Code for your main method can go here.
    #
    # Your code should find a sequence of RobotConfig objects such that all configurations are collision free, the
    # distance between 2 successive configurations is less than 1 primitive step, the first configuration is the initial
    # state and the last configuration is the goal state.
    #
    #

    sample_list = [init_node, goal_node]
    grapple_points = spec.grapple_points[:]
    num_grapple_points = spec.num_grapple_points
    if spec.num_grapple_points > 1:
        if (spec.num_grapple_points % 2 == 0) and (spec.goal.ee1_grappled is True):
            spec.num_grapple_points -= 1
            spec.grapple_points.pop(2)
        for i in range(spec.num_grapple_points - 1):
            for _ in range(NUM_BRIDGES):
                sample_list.append(bridge_config(spec, spec.initial, i))
    # print(sample_list)

    while True:
        temp_list = []
        while len(temp_list) < SAMPLE_SIZE:
            for i in range(spec.num_grapple_points):
                sample = generate_sample(spec, spec.initial, i)
                if (sample not in sample_list) and (sample not in temp_list):
                    temp_list.append(sample)
                else:
                    continue

        sample_list += temp_list
        for i in range(len(sample_list) - 1):
            for j in range(i + 1, len(sample_list)):
                xi1, yi1 = sample_list[i].config.points[0]
                xj1, yj1 = sample_list[j].config.points[0]
                xi2, yi2 = sample_list[i].config.points[-1]
                xj2, yj2 = sample_list[j].config.points[-1]

                if point_is_close(xi1, yi1, xj1, yj1, spec.TOLERANCE) or point_is_close(xi2, yi2, xj2, yj2,
                                                                                        spec.TOLERANCE):
                    if (dist(sample_list[i].config, sample_list[j].config, spec) <= DIST_THRESHOLD) and \
                            (sample_list[j] not in sample_list[i].neighbors):
                        if interpolation_path(sample_list[i].config, sample_list[j].config, spec):
                            sample_list[i].add_connection(sample_list[i], sample_list[j])
        config_list = find_graph_path(spec, init_node)
        if config_list is not None:
            for i in range(len(config_list) - 1):
                path = interpolation_path(config_list[i], config_list[i + 1], spec)
                if not path:
                    continue
                else:
                    steps += path

            break
    spec.grapple_points = grapple_points[:]
    spec.num_grapple_points = num_grapple_points

    if len(arglist) > 1:
        write_robot_config_list_to_file(output_file, steps)

    #
    # You may uncomment this line to launch visualiser once a solution has been found. This may be useful for debugging.
    # *** Make sure this line is commented out when you submit to Gradescope ***
    #
    # t_elapsed = time.time() - t_start
    # print(t_elapsed)
    # v = Visualiser(spec, steps)


if __name__ == '__main__':
    main(sys.argv[1:])
    # main(('testcases/4g4_m1.txt', 'output.txt'))
