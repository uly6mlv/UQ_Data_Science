#!/usr/bin/python
import sys
from laser_tank import LaserTankMap
import queue
import time
"""
Template file for you to implement your solution to Assignment 1.

COMP3702 2020 Assignment 1 Support Code
"""

#
#
# Code for any classes or functions you need can go here.
#
#
MOVE_FORWARD = 'f'
TURN_LEFT = 'l'
TURN_RIGHT = 'r'
SHOOT_LASER = 's'
MOVES = [MOVE_FORWARD, TURN_LEFT, TURN_RIGHT, SHOOT_LASER]


class NewLaserTankMap(LaserTankMap):
    def __init__(self, x_size, y_size, grid_data, player_x, player_y, player_heading, cost=1):
        super().__init__(x_size, y_size, grid_data, player_x, player_y, player_heading)
        self.cost = cost
        self.total_coast = cost
        self.id = tuple((self.get_tuple_grid_data(), self.player_x, self.player_y, self.player_heading))

    def update_id(self):
        self.id = tuple((self.get_tuple_grid_data(), self.player_x, self.player_y, self.player_heading))

    def get_tuple_grid_data(self):
        return tuple(map(tuple, self.grid_data))

    def __lt__(self, other):
        return self.total_cost < other.total_cost

    def heuristic(self, x_goal, y_goal):
        return abs(x_goal - self.player_x) + abs(y_goal - self.player_y)
        # return 0


def astar_search(game_map, x_flag, y_flag):
    game_map = NewLaserTankMap(game_map.x_size, game_map.y_size, game_map.grid_data, game_map.player_x,
                               game_map.player_y, game_map.player_heading)
    fringe = queue.PriorityQueue()
    fringe.put(game_map)
    path = {game_map.id: []}  # a dict of `vertex: actions`
    explored = {game_map.id: 0}
    # count = 0
    while not fringe.empty():
        current = fringe.get()
        if current.is_finished():
            # print(count)
            # print(fringe.qsize())
            # print(len(explored))
            return path[current.id]
        for move in MOVES:  # "simulate" executing actions
            cost_so_far = explored[current.id] + current.cost
            # neighbor = copy.deepcopy(current)
            neighbor = NewLaserTankMap(current.x_size, current.y_size, [x[:] for x in current.grid_data],
                                       current.player_x, current.player_y, current.player_heading)
            result = neighbor.apply_move(move)
            neighbor.update_id()
            if result == 0:
                # count += 1
                if (neighbor.id not in explored) or (cost_so_far < explored[neighbor.id]):
                    explored[neighbor.id] = cost_so_far
                    path[neighbor.id] = path[current.id] + [move]
                    vfp = cost_so_far + neighbor.heuristic(x_flag, y_flag)
                    neighbor.total_cost = vfp
                    fringe.put(neighbor)
                    # neighbor.render()


def write_output_file(filename, actions):
    """
    Write a list of actions to an output file. You should use this method to write your output file.
    :param filename: name of output file
    :param actions: list of actions where is action is in LaserTankMap.MOVES
    """
    f = open(filename, 'w')
    for i in range(len(actions)):
        f.write(str(actions[i]))
        if i < len(actions) - 1:
            f.write(',')
    f.write('\n')
    f.close()


def main(arglist):
    input_file = arglist[0]
    output_file = arglist[1]
    t_start = time.time()

    # Read the input testcase file
    game_map = LaserTankMap.process_input_file(input_file)
    actions = []
    #
    #
    # Code for your main method can go here.
    #
    # Your code should find a sequence of actions for the agent to follow to reach the goal, and store this sequence
    # in 'actions'.
    #
    #
    for i in range(len(game_map.grid_data)):
        if "F" in game_map.grid_data[i]:
            y_flag = i
            x_flag = game_map.grid_data[i].index("F")
    actions = astar_search(game_map, x_flag, y_flag)
    # Write the solution to the output file
    write_output_file(output_file, actions)
    t_elapsed = time.time() - t_start
    print(t_elapsed)


if __name__ == '__main__':
    main(sys.argv[1:])
    # main(["testcases/t3_the_river.txt", "output.txt"])
