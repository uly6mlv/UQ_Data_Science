EMPTY_TILE = "tile"
START_PIPE = "start"
END_PIPE = "end"
LOCKED_TILE = "locked"

SPECIAL_TILES = {
    "S": START_PIPE,
    "E": END_PIPE,
    "L": LOCKED_TILE
}

PIPES = {
    "ST": "straight",
    "CO": "corner",
    "CR": "cross",
    "JT": "junction-t",
    "DI": "diagonals",
    "OU": "over-under"
}


class Tile(object):
    """
    The Tile class represents the playable space in the game board
    """
    def __init__(self, name, selectable=True):
        """
        Construct  the Tile class
        :param name: name of the tile (str)
        :param selectable: whether the tile is selectable (bool)
        """
        self._name = name
        self._selectable = selectable

    def get_name(self):
        """
        Get the name of tile
        :return: name of the tile (str)
        """
        return self._name

    def get_id(self):
        """
        Get the id of the tile
        :return: 'tile' (str)
        """
        return 'tile'

    def set_select(self, select):
        """
        Switch the selectable parameter between True and False
        :param select: value to be assigned to the selectable parameter (bool)
        :return: None
        """
        self._selectable = select

    def can_select(self):
        """
        Check whether the tile is selectable
        :return: selectable (bool)
        """
        return self._selectable

    def __str__(self):
        return "Tile(\'{0}\', {1})".format(self.get_name(), self._selectable)

    def __repr__(self):
        return "Tile(\'{0}\', {1})".format(self.get_name(), self._selectable)


class Pipe(Tile):
    """
    The Pipe class defines pipe objects in the game.
    It is a subclass of Tile.
    """
    def __init__(self, name, orientation=0, selectable=True):
        """
        Construct the Pipe class
        :param name: name of the pipe (str)
        :param orientation: an integer representing the orientation of the pipe (int)
        :param selectable: whether the pipe is selectable (bool)
        """
        super().__init__(name, selectable)
        self._orientation = orientation

    def get_id(self):
        """
        Get the id of the pipe
        :return: 'pipe' str)
        """
        return 'pipe'

    def get_connected(self, side):
        """
        Find which directions are connected with the pipe to the give side
        :param side: the input direction (str)
        :return: directions connected to side (list)
        """
        direction_list = ["N", "E", "S", "W"]
        if self.get_name() == "straight":
            result = [direction_list[self.get_orientation()], direction_list[self.get_orientation() - 2]]
            if side in result:
                result.remove(side)
                return result

        if self.get_name() == "corner":
            result = [direction_list[self.get_orientation()], direction_list[self.get_orientation() - 3]]
            if side in result:
                result.remove(side)
                return result

        if self.get_name() == "cross":
            direction_list.remove(side)
            return direction_list

        if self.get_name() == "junction-t":
            direction_list.pop(self.get_orientation())
            if side in direction_list:
                direction_list.remove(side)
                return direction_list

        if self.get_name() == "diagonals":
            result_1 = [direction_list[self.get_orientation()], direction_list[self.get_orientation() - 3]]
            result_2 = [direction_list[self.get_orientation() - 1], direction_list[self.get_orientation() - 2]]
            if side in result_1:
                result_1.remove(side)
                return result_1
            elif side in result_2:
                result_2.remove(side)
                return result_2

        if self.get_name() == "over-under":
            result_1 = ["N", "S"]
            result_2 = ["E", "W"]
            if side in result_1:
                result_1.remove(side)
                return result_1
            elif side in result_2:
                result_2.remove(side)
                return result_2
        return []

    def rotate(self, direction):
        """
        Rotate the pipe. A positive(or negative) direction implies clockwise(or counter-clockwise) rotation and 0 means
        no rotation.
        :param direction: direction of rotation of pipe orientation (int)
        :return: new orientation of the pipe (int)
        """
        orientation_list = [0, 1, 2, 3]
        self._orientation = orientation_list[(self.get_orientation() + direction) % 4]

    def get_orientation(self):
        """
        Get the orientation of the pipe
        :return: orientation (int)
        """
        return self._orientation

    def __str__(self):
        return "Pipe(\'{0}\', {1})".format(self.get_name(), self.get_orientation())

    def __repr__(self):
        return "Pipe(\'{0}\', {1})".format(self.get_name(), self.get_orientation())


class SpecialPipe(Pipe):
    """
    The SpecialPipe class is a subclass of Pipe, defines special types of Pipe
    """
    def __init__(self, name, orientation=0, selectable=False):
        """
        Construct the SpecialPipe
        :param name: name of the special pipe (str)
        :param orientation: orientation of the special pipe (int)
        :param selectable: whether the pipe is selectable (bool)
        """
        super().__init__(name, orientation, selectable)

    def get_id(self):
        """
        Get the id of the special pipe
        :return: 'special_pipe' (str)
        """
        return 'special_pipe'

    def __str__(self):
        return "SpecialPipe({0})".format(self.get_orientation())

    def __repr__(self):
        return "SpecialPipe({0})".format(self.get_orientation())


class StartPipe(SpecialPipe):
    """
    StartPipe is the start pipe of the game.
    It is a subclass of SpecialPipe.
    """
    def __init__(self, orientation=0):
        """
        Construct the StartPipe class
        :param orientation: orientation of the start pipe (int)
        """
        super().__init__(orientation)
        self._orientation = orientation

    def get_name(self):
        """
        Get the name of the start pipe
        :return: 'start' (str)
        """
        return 'start'

    def get_connected(self, side=None):
        """
        Get the direction that the start pipe is facing
        :param side: None
        :return: direction the start pipe is facing (str)
        """
        facing_list = ["N", "E", "S", "W"]
        return list(facing_list[self.get_orientation()])

    def __str__(self):
        return "StartPipe({0})".format(self.get_orientation())

    def __repr__(self):
        return "StartPipe({0})".format(self.get_orientation())


class EndPipe(SpecialPipe):
    """
    EndPipe is the end pipe of the game.
    It is a subclass of SpecialPipe
    """
    def __init__(self, orientation=0):
        """
        Construct the EndPipe class
        :param orientation: orientation of the end pipe (int)
        """
        super().__init__(orientation)
        self._orientation = orientation

    def get_name(self):
        """
        Get the name of the end pipe
        :return: 'end' (str)
        """
        return 'end'

    def get_connected(self, side=None):
        """
        Get the opposite direction that the end pipe's facing
        :param side: None
        :return: opposite direction that the end pipe's facing (str)
        """
        opposite_list = ["S", "W", "N", "E"]
        return list(opposite_list[self.get_orientation()])

    def __str__(self):
        return "EndPipe({0})".format(self.get_orientation())

    def __repr__(self):
        return "EndPipe({0})".format(self.get_orientation())


class PipeGame:
    """
    A game of Pipes.
    """

    def __init__(self, game_file='game_1.csv'):
        """
        Construct a game of Pipes from a file name.

        Parameters:
            game_file (str): name of the game file.
        """
        # #########################COMMENT THIS SECTION OUT WHEN DOING load_file#######################
        # board_layout = [[Tile('tile', True), Tile('tile', True), Tile('tile', True), Tile('tile', True), \
        # Tile('tile', True), Tile('tile', True)], [StartPipe(1), Tile('tile', True), Tile('tile', True), \
        # Tile('tile', True), Tile('tile', True), Tile('tile', True)], [Tile('tile', True), Tile('tile', True), \
        # Tile('tile', True), Pipe('junction-t', 0, False), Tile('tile', True), Tile('tile', True)], [Tile('tile', True), \
        # Tile('tile', True), Tile('tile', True), Tile('tile', True), Tile('locked', False), Tile('tile', True)], \
        # [Tile('tile', True), Tile('tile', True), Tile('tile', True), Tile('tile', True), EndPipe(3), \
        # Tile('tile', True)], [Tile('tile', True), Tile('tile', True), Tile('tile', True), Tile('tile', True), \
        # Tile('tile', True), Tile('tile', True)]]
        #
        # playable_pipes = {'straight': 1, 'corner': 1, 'cross': 1, 'junction-t': 1, 'diagonals': 1, 'over-under': 1}
        #########################COMMENT THIS SECTION OUT WHEN DOING load_file#######################

        ### add code here ###
        playable_pipes, board_layout = self.load_file(game_file)
        self._board_layout = board_layout
        self._playable_pipes = playable_pipes
        self.end_pipe_positions()

    def get_board_layout(self):
        """
        Get the layout of the game board
        :return: board_layout (list)
        """
        return self._board_layout

    def get_playable_pipes(self):
        """
        Get the name of pipes and their quantity
        :return: playable_pipes (dict)
        """
        return self._playable_pipes

    def change_playable_amount(self, pipe_name, number):
        """
        Change the amount of playable pipes
        :param pipe_name: name of the playable pipe (str)
        :param number: amount of the playable pipe (int)
        :return: None
        """
        self.get_playable_pipes()[pipe_name] += number

    def get_pipe(self, position):
        """
        Get the pipe or tile at the given position
        :param position: position on the game board (tuple<int, int>)
        :return: Pipe (class) or Tile (class)
        """
        return self.get_board_layout()[position[0]][position[1]]

    def set_pipe(self, pipe, position):
        """
        Place a selected pipe at the position
        :param pipe: Pipe (class)
        :param position: position on the game board (tuple<int, int>)
        :return: None
        """
        self.get_board_layout()[position[0]][position[1]] = pipe
        self.change_playable_amount(pipe.get_name(), -1)

    def pipe_in_position(self, position):
        """
        Get the Pipe at the given position, or None if there is no pipe.
        :param position: position on the game board (tuple<int, int>)
        :return: Pipe (class) or None
        """
        if position is not None:
            if self.get_pipe(position).get_id() in ["pipe", "special_pipe"]:
                return self.get_pipe(position)
            else:
                return

    def remove_pipe(self, position):
        """
        Remove the pipe at the given position
        :param position: position on the game board (tuple<int, int>)
        :return: None
        """
        self.change_playable_amount(self.pipe_in_position(position).get_name(), 1)
        self.get_board_layout()[position[0]][position[1]] = Tile('tile')

    def position_in_direction(self, direction, position):
        """
        Get the direction and position in the given direction from the given position
        :param direction: direction from the given position (str)
        :param position: position on the game board (tuple<int, int>)
        :return: direction (str) and position (tuple<int, int>)
        """
        direction_list = ["N", "E", "S", "W"]
        height = len(self.get_board_layout())
        width = len(self.get_board_layout()[0])
        if direction == "N":
            if position[0] - 1 in range(height):
                return direction_list[direction_list.index(direction) - 2], (position[0] - 1, position[1])
        elif direction == "S":
            if position[0] + 1 in range(height):
                return direction_list[direction_list.index(direction) - 2], (position[0] + 1, position[1])
        elif direction == "E":
            if position[1] + 1 in range(width):
                return direction_list[direction_list.index(direction) - 2], (position[0], position[1] + 1)
        else:
            if position[1] - 1 in range(width):
                return direction_list[direction_list.index(direction) - 2], (position[0], position[1] - 1)

    def end_pipe_positions(self):
        """
        Get the and save the positions of start pipe and end pipe.
        :return: None
        """
        for sublist in self.get_board_layout():
            for item in sublist:
                if item.get_name() == "start":
                    self._starting_position = (self.get_board_layout().index(sublist), sublist.index(item))
                elif item.get_name() == "end":
                    self._ending_position = (self.get_board_layout().index(sublist), sublist.index(item))

    def get_starting_position(self):
        """
        Get the position of start pipe
        :return: position of start pipe (tuple<int, int>)
        """
        return self._starting_position

    def get_ending_position(self):
        """
        Get the position of end pipe
        :return: position of end pipe (tuple<int, int>)
        """
        return self._ending_position

    def check_win(self):
        """
         (bool) Returns True  if the player has won the game False otherwise.
         """
        position = self.get_starting_position()
        pipe = self.pipe_in_position(position)
        queue = [(pipe, None, position)]
        discovered = [(pipe, None)]
        while queue:
            pipe, direction, position = queue.pop()
            for direction in pipe.get_connected(direction):
                if self.position_in_direction(direction, position) is None:
                    new_direction = None
                    new_position = None
                else:
                    new_direction, new_position = self.position_in_direction(direction, position)
                if new_position == self.get_ending_position() and direction == self.pipe_in_position(
                        new_position).get_connected()[0]:
                    return True
                pipe = self.pipe_in_position(new_position)
                if pipe is None or (pipe, new_direction) in discovered:
                    continue
                discovered.append((pipe, new_direction))
                queue.append((pipe, new_direction, new_position))
        return False

    def load_file(self, filename):
        """
        Read a .csv file and set board_layout and playable_pipes according to it
        :param filename: filename of rhe .csv file (str)
        :return: playable_pipes (dict) and board_layout (list)
        """
        import csv
        with open(filename) as csvfile:
            csv_file = csv.reader(csvfile)
            csv_list = []
            for row in csv_file:
                csv_list.append(row)
        board__layout = csv_list[:-1]
        quantity = csv_list[-1]
        for sublist in board__layout:
            for item in sublist:
                if item == "#":
                    sublist[sublist.index(item)] = Tile('tile', True)
                elif not item[-1].isnumeric():
                    if item in PIPES:
                        sublist[sublist.index(item)] = Pipe(PIPES[item])
                    elif item == "S":
                        sublist[sublist.index(item)] = StartPipe()
                    elif item == "E":
                        sublist[sublist.index(item)] = EndPipe()
                    elif item == "L":
                        sublist[sublist.index(item)] = Tile(SPECIAL_TILES[item], False)
                elif item[-1].isnumeric():
                    if item[:-1] in PIPES:
                        sublist[sublist.index(item)] = Pipe(PIPES[item[:-1]], int(item[-1]))
                    elif item[:-1] == "S":
                        sublist[sublist.index(item)] = StartPipe(int(item[-1]))
                    elif item[:-1] == "E":
                        sublist[sublist.index(item)] = EndPipe(int(item[-1]))
        playable_pipes = {'straight': int(quantity[0]), 'corner': int(quantity[1]), 'cross': int(quantity[2]),
                          'junction-t': int(quantity[3]), 'diagonals': int(quantity[4]), 'over-under': int(quantity[5])}
        return playable_pipes, board__layout


def main():
    print("Please run gui.py instead")


if __name__ == "__main__":
    main()
