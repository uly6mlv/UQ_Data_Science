from laser_tank import LaserTankMap, DotDict
import time
import random
import pandas as pd

"""
Template file for you to implement your solution to Assignment 4. You should implement your solution by filling in the
following method stubs:
    train_q_learning()
    train_sarsa()
    get_policy()

You may add to the __init__ method if required, and can add additional helper methods and classes if you wish.

To ensure your code is handled correctly by the autograder, you should avoid using any try-except blocks in your
implementation of the above methods (as this can interfere with our time-out handling).

COMP3702 2020 Assignment 4 Support Code
"""


class Solver:

    def __init__(self):
        """
        Initialise solver without a Q-value table.
        """

        #
        # TODO
        # You may add code here if you wish (e.g. define constants used by both methods).
        #
        # The allowed time for this method is 1 second.
        #

        self.q_values = None
        self.learning_rate = 0.1  # 'alpha' in lecture notes
        # self.gamma = LaserTankMap.gamma
        self.exploit_prob = 0.9

    def train_q_learning(self, simulator: LaserTankMap):
        print('q-learning')
        """
        Train the agent using Q-learning, building up a table of Q-values.
        :param simulator: A simulator for collecting episode data (LaserTankMap instance)
        """

        # Q(s, a) table
        # suggested format: key = hash(state), value = dict(mapping actions to values)
        q_values = {}

        #
        # TODO
        # Write your Q-Learning implementation here.
        #
        # When this method is called, you are allowed up to [state.time_limit] seconds of compute time. You should
        # continue training until the time limit is reached.
        #
        start = time.time()
        reward_list = []
        episode_reward = []
        while time.time() - start < simulator.time_limit:
            s = simulator.__hash__()
            a = self.choose_action(simulator, q_values)
            if s not in q_values:
                q_values[s] = {}
            q_s = q_values[s]
            if a in q_s:
                old_q = q_s[a]
            else:
                old_q = .0

            r, episode_finished = simulator.apply_move(a)
            reward_list.append(r)
            next_s = simulator.__hash__()
            if next_s not in q_values:
                q_values[next_s] = {}
            next_s_q = {}

            for action in simulator.MOVES:
                # print(action)
                next_s_q[action] = .0
                if action in q_values[next_s]:
                    next_s_q[action] = q_values[next_s][action]

            best_next_q = next_s_q[dict_argmax(next_s_q)]

            # update q_values(s,a,r,old_q,best_next_q)
            td = r + (simulator.gamma * best_next_q) - old_q
            q_values[s][a] = old_q + (self.learning_rate * td)
            if episode_finished:
                episode_reward.append(sum(reward_list))
                reward_list = []
                simulator.reset_to_start()
        df = pd.DataFrame(episode_reward)
        # df.to_csv('episode.csv', index=False)
        # store the computed Q-values
        self.q_values = q_values

    def train_sarsa(self, simulator):
        print('sarsa')
        """
        Train the agent using SARSA, building up a table of Q-values.
        :param simulator: A simulator for collecting episode data (LaserTankMap instance)
        """

        # Q(s, a) table
        # suggested format: key = hash(state), value = dict(mapping actions to values)
        q_values = {}

        #
        # TODO
        # Write your SARSA implementation here.
        #
        # When this method is called, you are allowed up to [state.time_limit] seconds of compute time. You should
        # continue training until the time limit is reached.
        #
        start = time.time()
        a = self.choose_action(simulator, q_values)
        reward_list = []
        episode_reward = []
        while time.time() - start < simulator.time_limit:
            s = simulator.__hash__()
            if s not in q_values:
                q_values[s] = {}
            q_s = q_values[s]
            if a in q_s:
                old_q = q_s[a]
            else:
                old_q = .0
            r, episode_finished = simulator.apply_move(a)
            reward_list.append(r)
            next_s = simulator.__hash__()
            next_a = self.choose_action(simulator, q_values)
            if next_s not in q_values:
                q_values[next_s] = {}
            if next_a not in q_values[next_s]:
                q_values[next_s][next_a] = .0

            new_q = q_values[next_s][next_a]
            # update q_values(s,a,r,old_q,best_next_q)
            td = r + (simulator.gamma * new_q) - old_q
            q_values[s][a] = old_q + (self.learning_rate * td)
            a = next_a
            if episode_finished:
                episode_reward.append(sum(reward_list))
                reward_list = []
                simulator.reset_to_start()
                random_restart(simulator)
        df = pd.DataFrame(episode_reward)
        df.to_csv('episode.csv', index=False)
        # store the computed Q-values
        self.q_values = q_values

    def get_policy(self, state):
        """
        Get the policy for this state (i.e. the action that should be performed at this state).
        :param state: a LaserTankMap instance
        :return: pi(s) [an element of LaserTankMap.MOVES]
        """

        #
        # TODO
        # Write code to return the optimal action to be performed at this state based on the stored Q-values.
        #
        # You can assume that either train_q_learning( ) or train_sarsa( ) has been called before this
        # method is called.
        #
        # When this method is called, you are allowed up to 1 second of compute time.
        #
        s = state.__hash__()
        q_s = self.q_values.get(s, {})
        a = dict_argmax(q_s)
        # print(a)
        return a
        # pass

    def choose_action(self, simulator, q_values):
        """
        Write a method to choose an action here
        Incorporate your agent's exploration strategy in this method
        """
        s = simulator.__hash__()
        q_s = q_values.get(s, {})
        if len(q_s) == 0 or random.random() > self.exploit_prob:
            a = random.choice(LaserTankMap.MOVES)
        else:
            a = dict_argmax(q_s)
        # print(a)
        return a


def random_restart(simulator):
    """
    Restart the agent in a random map location, avoidng obstacles
    """
    conflict = True
    while conflict:
        simulator.player_x = random.randint(0, simulator.x_size - 1)
        simulator.player_y = random.randint(0, simulator.y_size - 1)
        simulator.player_heading = random.choice(simulator.DIRECTIONS)
        conflict = False
        if simulator.cell_is_blocked(simulator.player_y, simulator.player_x):
            conflict = True


def dict_argmax(d):
    return max(d, key=d.get)
