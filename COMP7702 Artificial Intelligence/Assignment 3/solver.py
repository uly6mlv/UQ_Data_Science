from laser_tank import LaserTankMap , DotDict

"""
Template file for you to implement your solution to Assignment 3. You should implement your solution by filling in the
following method stubs:
    run_value_iteration()
    run_policy_iteration()
    get_offline_value()
    get_offline_policy()
    get_mcts_policy()
    
You may add to the __init__ method if required, and can add additional helper methods and classes if you wish.

To ensure your code is handled correctly by the autograder, you should avoid using any try-except blocks in your
implementation of the above methods (as this can interfere with our time-out handling).

COMP3702 2020 Assignment 3 Support Code
"""
MOVE_FORWARD , TURN_LEFT , TURN_RIGHT , SHOOT_LASER = "f" , "l" , "r" , "s"
MOVES = [MOVE_FORWARD , TURN_LEFT , TURN_RIGHT]
# directions
UP , DOWN , LEFT , RIGHT = 0 , 1 , 2 , 3
DIRECTIONS = [UP , DOWN , LEFT , RIGHT]
UU, DD, LL, RR, UL , UR , DL , DR , NM = ["UU", "DD", "LL", "RR", "UL" , "UR" , "DL" , "DR" , "NM"]
WATER_SYMBOL , TELEPORT_SYMBOL , FLAG_SYMBOL , OBSTACLE_SYMBOL , ICE_SYMBOL = ['W' , 'T' , 'F' , "#" , "I"]
SPECIAL_TILES = [WATER_SYMBOL , TELEPORT_SYMBOL , FLAG_SYMBOL]
EXIT_STATES = [WATER_SYMBOL, FLAG_SYMBOL]

class Solver:

    def __init__(self , game_map):
        self.game_map = game_map  # type: LaserTankMap
        self.max_iterations = 100
        self.p = self.game_map.t_success_prob
        self.discount = self.game_map.gamma
        self.epsilon = self.game_map.epsilon

        self.rewards = {"move_cost": self.game_map.move_cost ,
                        "collision_cost": self.game_map.collision_cost ,
                        "game_over_cost": self.game_map.game_over_cost ,
                        "goal_reward": self.game_map.goal_reward}
        self.actions = MOVES


        x_size , y_size , grid_data = self.game_map.x_size , self.game_map.y_size , self.game_map.grid_data
        self.states = list((x , y , heading) for x in range(x_size) \
                           for y in range(y_size) \
                           for heading in DIRECTIONS \
                           if grid_data[y][x] != OBSTACLE_SYMBOL and grid_data[y][x] not in  EXIT_STATES)  # states without obstacles
        self.tester = list((x , y , heading,grid_data[y][x] ) for x in range(x_size) \
                           for y in range(y_size) \
                           for heading in DIRECTIONS \
                           if grid_data[y][x] != OBSTACLE_SYMBOL and grid_data[y][x] not in  EXIT_STATES)  # states without obstacles

        # store special tiles
        self.special_tiles_list = SPECIAL_TILES

        self.special_tiles = {}
        for x in range(x_size):
            for y in range(y_size):
                if grid_data[y][x] in SPECIAL_TILES:
                    if grid_data[y][x] not in self.special_tiles.keys():
                        self.special_tiles[grid_data[y][x]] = ((x , y) ,)
                    else:
                        self.special_tiles[grid_data[y][x]] += ((x , y) ,)

        self.values = None
        self.policy = None
        self.converged = False
        self.k = 10

    def stochastic_action(self , s , m):
        # stacastic action probabilites

        # set heading
        heading , p , q = s[2] , self.game_map.t_success_prob , self.game_map.t_error_prob
        p_ = q/5

        # if forward move
        if m == MOVE_FORWARD:
            if heading == UP:
                stoc_a = {UU: p, UL : p_, UR : p_, LL: p_, RR: p_, NM: p_}
            elif heading == RIGHT:
                stoc_a = {RR: p, UR: p_, DR: p_, UU: p_, DD: p_, NM: p_}
            elif heading == LEFT:
                stoc_a = {LL: p, UL: p_, DL: p_, UU: p_, DD: p_, NM: p_}
            elif heading == DOWN:
                stoc_a = {DD: p, DL: p_, DR: p_, LL: p_, RR: p_, NM: p_}
        elif m == TURN_LEFT:
            stoc_a ={TURN_LEFT : 1}
        elif m == TURN_RIGHT:
            stoc_a ={TURN_RIGHT : 1}
        # else:
        #     stoc_a = {}
        return stoc_a

    def attempt_move_get_reward(self, s, a):

        # store current state
        x, y, heading = s[0], s[1], s[2]
        x_size, y_size = self.game_map.x_size , self.game_map.y_size

        # move forward
        if a not in  [TURN_LEFT, TURN_RIGHT]:
            if a == UU:
                next_y, next_x = y - 1, x
            elif a == UR:
                next_y, next_x = y - 1, x + 1
            elif a == RR:
                next_y , next_x = y , x + 1
            elif a == DR:
                next_y , next_x = y + 1 , x + 1
            elif a == DD:
                next_y , next_x = y + 1 , x
            elif a == DL:
                next_y , next_x = y + 1 , x - 1
            elif a == LL:
                next_y , next_x = y , x - 1
            elif a == UL:
                next_y , next_x = y - 1 , x - 1
            elif a == NM:
                next_y , next_x = y , x


            # if next_y < 0 or  next_y >= y_size or next_x < 0 or next_x >= x_size:
            #     return s, self.rewards["collision_cost"]


            if self.game_map.grid_data[next_y][next_x] == ICE_SYMBOL:
                # handle ice tile - slide until first non-ice tile or blocked
                if heading == UP:
                    for i in range(next_y, -1, -1):
                        if self.game_map.grid_data[i][next_x] != ICE_SYMBOL:
                            if self.game_map.grid_data[i][next_x] == WATER_SYMBOL:
                                # slide into water - game over
                                return s, self.rewards["game_over_cost"]
                            elif self.game_map.cell_is_blocked(i, next_x):
                                # if blocked, stop on last ice cell
                                next_y = i + 1
                                break
                            else:
                                next_y = i
                                break
                elif heading == DOWN:
                    for i in range(next_y, y_size):
                        if self.game_map.grid_data[i][next_x] != ICE_SYMBOL:
                            if self.game_map.grid_data[i][next_x] == WATER_SYMBOL:
                                # slide into water - game over
                                return s, self.rewards["game_over_cost"]
                            elif self.game_map.cell_is_blocked(i, next_x):
                                # if blocked, stop on last ice cell
                                next_y = i - 1
                                break
                            else:
                                next_y = i
                                break
                elif heading == LEFT:
                    for i in range(next_x, -1, -1):
                        if self.game_map.grid_data[next_y][i] != ICE_SYMBOL:
                            if self.game_map.grid_data[next_y][i] == WATER_SYMBOL:
                                # slide into water - game over
                                return s, self.rewards["game_over_cost"]
                            elif self.game_map.cell_is_blocked(next_y, i):
                                # if blocked, stop on last ice cell
                                next_x = i + 1
                                break
                            else:
                                next_x = i
                                break
                else:
                    for i in range(next_x, x_size):
                        if self.game_map.grid_data[next_y][i] != ICE_SYMBOL:
                            if self.game_map.grid_data[next_y][i] == WATER_SYMBOL:
                                # slide into water - game over
                                return s, self.rewards["game_over_cost"]
                            elif self.game_map.cell_is_blocked(next_y, i):
                                # if blocked, stop on last ice cell
                                next_x = i - 1
                                break
                            else:
                                next_x = i
                                break
            if self.game_map.grid_data[next_y][next_x] == TELEPORT_SYMBOL:
                # handle teleport - find the other teleporter
                tpy, tpx = (None, None)
                for i in range(y_size):
                    for j in range(x_size):
                        if self.game_map.grid_data[i][j] == TELEPORT_SYMBOL and i != next_y and j != next_x:
                            tpy, tpx = (i, j)
                            break
                    if tpy is not None:
                        break
                if tpy is None:
                    raise Exception("LaserTank Map Error: Unmatched teleport symbol")
                next_y, next_x = (tpy, tpx)
            else:
                # if not ice or teleport, perform collision check
                if self.game_map.cell_is_blocked(next_y, next_x):
                    return s, self.rewards["collision_cost"]

            # check for game over conditions
            if self.game_map.cell_is_game_over(next_y, next_x):
                # print(True, "water")
                return s, self.rewards["game_over_cost"]

            # no collision and no game over - update player position
            new_s = (next_x , next_y , heading)

        elif a == TURN_LEFT:
            if heading == UP:
                heading = LEFT
            elif heading == DOWN:
                heading = RIGHT
            elif heading == LEFT:
                heading = DOWN
            else:
                heading = UP
            s = (x, y, heading)
            return s, self.rewards["move_cost"]
        elif a == TURN_RIGHT:
            # no collision or game over possible
            if heading == UP:
                heading = RIGHT
            elif heading == DOWN:
                heading = LEFT
            elif heading == LEFT:
                heading = UP
            else:
                heading = DOWN
            s = (x , y , heading)
            return s , self.rewards["move_cost"]

        new_s = (next_x , next_y , heading)
        if self.game_map.cell_is_blocked(next_y, next_x):
            return s, self.rewards["collision_cost"]
        if self.game_map.cell_is_game_over(next_y, next_x):
            return s, self.rewards["game_over_cost"]

        if self.game_map.grid_data[next_y][next_x] == FLAG_SYMBOL:
            return new_s, self.rewards["goal_reward"]
        else:
            return new_s, self.rewards["move_cost"]

    def run_value_iteration(self):
        """
        Build a value table and a policy table using value iteration, and store inside self.values and self.policy.
        """


        values = [[[0 for _ in LaserTankMap.DIRECTIONS]
                   for __ in range(1 , self.game_map.y_size - 1)]
                  for ___ in range(1 , self.game_map.x_size - 1)]
        policy = [[[-1 for _ in LaserTankMap.DIRECTIONS]
                   for __ in range(1 , self.game_map.y_size - 1)]
                  for ___ in range(1 , self.game_map.x_size - 1)]

        # copy of self.values initatiated with zeros
        # self.values = values.copy()

        self.max_iterations = 500
        for _ in range(self.max_iterations):
            max_delta = 0
            diff_list =[]
            for s in self.states:
                action_values = [0,0,0]
                for i,a in enumerate(self.actions):
                    total = 0
                    # print(s, a)
                    for stoch_action, p in self.stochastic_action(s,a).items():
                        # print(stoch_action, p)
                        # apply action
                        # print(stoch_action, p)
                        s_next , reward = self.attempt_move_get_reward(s, stoch_action)
                        # print(s_next, reward)
                        action_values[i] += p * (reward + (self.discount * values[s_next[0]-1][s_next[1]-1][s_next[2]]))
                        # print(s_next, reward)
                    # print((action_values))

                best_action_val = max(action_values)
                # print(best_action_val)
                # print(values[s[0] - 1][s[1] - 1][s[2]])
                    # keep max diff tab\ max delta:
                delta = max(max_delta, abs(values[s[0] - 1][s[1] - 1][s[2]] - best_action_val))
                # print(delta)
                diff_list.append(delta)

                # update state with max value

                values[s[0]-1][s[1]-1][s[2]] =  best_action_val

                best_act_index = action_values.index(max(action_values))

                policy[s[0]-1][s[1]-1][s[2]] = MOVES[best_act_index]
                # print(best_act_index , best_action_val)


            # if _ ==2:
            #     self.game_map.player_y, self.game_map.player_x, self.game_map.player_heading = s[1], s[0], s[2]
            #     self.game_map.render()
            #     print(s, s_next)
            #     for i , value_row in enumerate(values):
            #         print([[round(val, 2) for val in val_list] for val_list in value_row], "\n"*0)
            #         # print([[val for val in val_list] for val_list in policy[i]] , "\n" * 0)
            #         print("\n" * 2)

                    # print(max_delta)
                # break

            if max(diff_list) < self.epsilon:
                self.converged = True
                print("iteration" , _)
                break
            # print(self.values, "\n"*2,values)


        self.values = values
        self.policy = policy
        for i , value_row in enumerate(values):

            print([[round(val, 2) for val in val_list] for val_list in value_row], "\n"*0)
            print([[val for val in val_list] for val_list in policy[i]] , "\n" * 0)
        print("\n" * 2)



        # print( values)
        # print("\n"*2)

        # When this method is called, you are allowed up to [state.time_limit] seconds of compute time. You should stop
        # iterating either when max_delta < epsilon, or when the time limit is reached, whichever occurs first.
        #

        # store the computed values and policy

    def run_policy_iteration(self):
        """
        Build a value table and a policy table using policy iteration, and store inside self.values and self.policy.
        """
        # values = [[[0 for _ in LaserTankMap.DIRECTIONS]
        #            for __ in range(1 , self.game_map.y_size - 1)]
        #           for ___ in range(1 , self.game_map.x_size - 1)]
        # policy = [[[-1 for _ in LaserTankMap.DIRECTIONS]
        #            for __ in range(1 , self.game_map.y_size - 1)]
        #           for ___ in range(1 , self.game_map.x_size - 1)]

        # blank value space
        values = self.blank_values_grid("values")
        policy = self.blank_values_grid("policy")

        self.values, self.policy = values.copy(), policy.copy()

        for i in range(self.max_iterations):
            self.policy_evaluation()
            Unchanged = True

            for s in self.states:
                action_values = [0 , 0 , 0]
                x , y , heading = s
                present_move = policy[x - 1][y - 1][heading]

                for i , a in enumerate(self.actions):
                    total = 0
                    for stoch_action , p in self.stochastic_action(s , a).items():
                        s_next , reward = self.attempt_move_get_reward(s , stoch_action)

                        action_values[i] += p * (reward + (self.discount * self.values[s_next[0] - 1][s_next[1] - 1][s_next[2]]))

                best_act_index = action_values.index(max(action_values))

                best_move = MOVES[best_act_index]

                if best_move != present_move:

                    Unchanged = False
                    policy[x - 1][y - 1][heading] = best_move

                for val in self.values:
                    print(val)
                for pol_row in policy:
                    print(pol_row)
                print("\n")


            if not Unchanged:
                print(i)
                print("converged")
                break

        self.policy = policy
        print(policy)

        # self.policy = self.blank_values_grid("policy")
        # self.values = self.blank_values_grid("values")
        # self.max_iterations =1000
        # for i in range(self.max_iterations):
        #
        #     self.policy_evaluation()
        #     self.policy_improvement()
        #
        #
        #     for val in self.policy:
        #         print(val)
        #     for val in self.values:
        #         print(val)
        #     print("\n"*2)
        #     if self.converged:
        #         print("converged")
        #         break

        # When this method is called, you are allowed up to [state.time_limit] seconds of compute time. You should stop
        # iterating either when max_delta < epsilon, or when the time limit is reached, whichever occurs first.
        #

        # store the computed values and policy
        # self.values = values
        # self.policy = policy

    def convergence_check(self, new_policy):
        if self.policy == new_policy:
            self.converged = True

    def next_iteration_for_policy(self):
        values= self.blank_values_grid("values")
        for s in self.states:
            x, y, heading = s
            a = self.policy[x-1][y-1][heading]
            # policy_values[x-1][y-1][heading] = 0.0
            for stoch_action , p in self.stochastic_action(s, a).items():
                # Apply action
                s_next, reward = self.attempt_move_get_reward(s , stoch_action)
                new_x, new_y, heading = s_next
                values[x-1][y-1][heading] += p * (reward + (self.discount
                                                                    * values[new_x-1][new_y-1][heading]))

        self.values = values.copy()
        del values


    def blank_values_grid(self, grid_name):
        if grid_name == "policy":
            policy = [[["r" for _ in LaserTankMap.DIRECTIONS]
                       for __ in range(1 , self.game_map.y_size - 1)]
                      for ___ in range(1 , self.game_map.x_size - 1)]
            return policy
        else:
            values = [[[0 for _ in LaserTankMap.DIRECTIONS]
                       for __ in range(1 , self.game_map.y_size - 1)]
                      for ___ in range(1 , self.game_map.x_size - 1)]
            return values

    def policy_improvement(self):
        new_policy = self.blank_values_grid("policy")
        for s in self.states:
            action_values = [0 , 0 , 0]
            x, y, heading = s
            present_move = self.policy[x-1][y-1][heading]
            is_policy_stable = False
            for i , a in enumerate(self.actions):
                total = 0
                for stoch_action , p in self.stochastic_action(s , a).items():
                    s_next , reward = self.attempt_move_get_reward(s , stoch_action)

                    action_values[i] += p * (reward + (self.discount * self.values[s_next[0] - 1][s_next[1] - 1][s_next[2]]))

            best_act_index = action_values.index(max(action_values))

            best_move = MOVES[best_act_index]



            if best_move != present_move:
                is_policy_stable = True

            new_policy[x - 1][y - 1][heading] = best_move


        # self.convergence_check(new_policy)

        # for i , value_row in enumerate(new_policy):
        #     print(value_row)
        #     # print([[val for val in val_list] for val_list in policy[i]] , "\n" * 0)
        #     print("\n" * 1)
        self.policy = new_policy

    def policy_evaluation(self):
        for kk in range(self.k):
            self.next_iteration_for_policy()


    def get_offline_value(self , state):
        """
        Get the value of this state.
        :param state: a LaserTankMap instance
        :return: V(s) [a floating point number]
        """
        x, y , heading = state
        return self.values[x-1][y-1][heading]

    def get_offline_policy(self , state: LaserTankMap):
        """
        Get the policy for this state (i.e. the action that should be performed at this state).
        :param state: a LaserTankMap instance
        :return: pi(s) [an element of LaserTankMap.MOVES]
        """
        x , y ,heading = state.player_x-1, state.player_y-1, state.player_heading
        return self.policy[x][y][heading]

    def get_mcts_policy(self , state):
        """
        Choose an action to be performed using online MCTS.
        :param state: a LaserTankMap instance
        :return: pi(s) [an element of LaserTankMap.MOVES]
        """

        #
        # TODO
        # Write your Monte-Carlo Tree Search implementation here.
        #
        # Each time this method is called, you are allowed up to [state.time_limit] seconds of compute time - make sure
        # you stop searching before this time limit is reached.
        #

        pass

    def show_grid(self):

        grid = ''
        for row in range(len(self.values)):
            each_row = ''
            for col in range(len(self.values)):
                for each_dir in range(4):
                    if self.values[row][col][each_dir] == 0.0:
                        each_row += ' ' + str(0) + '.00, '
                    else:
                        each_row += str(round(self.values[row][col][each_dir], 2)) + ', '
                each_row += " | "
            grid += each_row + '\n'

        print(grid)


# input_file = ["extra_t1.txt" , "pi_t0.txt" , "pi_t1.txt" , "vi_t0.txt" , "vi_t1.txt"]
# # # # #
# game_map = LaserTankMap.process_input_file(f"testcases/{input_file[1]}")
# solver = Solver(game_map)
# # #
# grid = solver.game_map.grid_data
# for row in grid:
#     print(str(row))
#
#
# # print(solver.tester)
# solver.run_policy_iteration()