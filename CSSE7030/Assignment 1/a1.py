from a1_support import *


def display_game(game, grid_size):
    """
    Print out the grids of game

    :param game: game string (str)
    :param grid_size: size of game (int)
    :return: None
    """
    # print header
    print("  " + WALL_VERTICAL, end='')
    for i in range(1, grid_size + 1):
        if i < 10:
            print(" " + str(i) + " " + WALL_VERTICAL, end="")
        else:
            print(" " + str(i) + WALL_VERTICAL, end="")
    print("\n" + WALL_HORIZONTAL * 4 * (grid_size + 1))
    # print the rest rows of the game grid
    for i in range(grid_size):
        print(ALPHA[i] + " " + WALL_VERTICAL, end="")
        line = ""
        for char in game[:grid_size]:
            line += " " + char + " " + WALL_VERTICAL
        line += "\n" + WALL_HORIZONTAL * 4 * (grid_size + 1)
        print(line)
        game = game[grid_size:]


def parse_position(action, grid_size):
    """
    Validate the player's action input

    :param action: player action (str)
    :param grid_size: size of game (int)
    :return: -None: if action invalid
             -tuple(int, int): if action is "Select a cell"(`-Upper Case Character--number-', e.g.'A1")
    """
    if len(action) < 2:
        return
    elif action[0].isupper() & action[1:].isnumeric() & (action[1] != '0'):
        if (ALPHA.index(action[0]) <= grid_size - 1) & (int(action[1:]) <= grid_size):
            return ALPHA.index(action[0]), int(action[1:]) - 1
    else:
        return


def position_to_index(position, grid_size):
    """
    Convert the position tuple(row, column) in the grid to the game string index

    :param position: position in the grid (tuple<int, int>)
    :param grid_size: size of game (int)
    :return: index of the game string (int)
    """
    return position[1] + position[0] * grid_size


def replace_character_at_index(game, index, character):
    """
    Replace the character with a new one at the specified index of game sting, unless the cell is flagged

    :param game: game string (str)
    :param index: index of the currently selected cell (int)
    :param character: new character to be placed at the specified index of game string (int or str)
    :return: an updated game string (str)
    """
    if game[index] == FLAG:
        return game
    else:
        game = game[:index] + str(character) + game[index + 1:]
        return game


def flag_cell(game, index):
    """
    Flag or unflag a cell at a specified index of game string
    * Exposed cells cannot be flagged

    :param game: game string (str)
    :param index: index of the currently selected cell (int)
    :return: an updated game string (str)
    """
    if game[index] == UNEXPOSED:
        game = replace_character_at_index(game, index, FLAG)
    elif game[index] == FLAG:
        game = game[:index] + UNEXPOSED + game[index + 1:]
    return game


def index_in_direction(index, grid_size, direction):
    """
    Move from a cell at a specified index of game string to a neighbour cell according to the given direction
    * Cannot move beyond the grid

    :param index: index of the currently selected cell (int)
    :param grid_size: size of game (int)
    :param direction: direction to move (str), from a1_support.py
    :return: -None: if the new position is beyond the grid
             -index: index of neighbour cell (int)
    """
    position = [index // grid_size, index % grid_size]
    if UP in direction:
        position[0] -= 1
    if DOWN in direction:
        position[0] += 1
    if LEFT in direction:
        position[1] -= 1
    if RIGHT in direction:
        position[1] += 1
    if (position[0] >= grid_size) | (position[1] >= grid_size) | (position[0] < 0) | (position[1] < 0):
        return
    else:
        return position_to_index(position, grid_size)


def neighbour_directions(index, grid_size):
    """
    Find the indexes of neighbour cells at a specified index of game string
    * All neighbour cells are inside the grid of game

    :param index: index of the currently selected cell (int)
    :param grid_size: size of game (int)
    :return: a list of indexes of neighbour cells (list<int, ...>)
    """
    lst = []
    for direction in DIRECTIONS:
        lst.append(index_in_direction(index, grid_size, direction))
    lst = list(filter(None.__ne__, lst))
    return lst


def number_at_cell(game, pokemon_locations, grid_size, index):
    """
    Find the number of pokemons in neighbour cells at a specified index of game string, unless the cell is flagged

    :param game: game string (str)
    :param pokemon_locations: indexes of pokemon locations (tuple<int, ...>)
    :param grid_size: size of game (int)
    :param index: index of the currently selected cell (int)
    :return: number of pokemons in neighbour cells (int)
    """
    if game[index] == FLAG:
        return FLAG
    elif index in pokemon_locations:
        return
    count = 0
    for neighbour in neighbour_directions(index, grid_size):
        if neighbour in pokemon_locations:
            count += 1
    return count


def check_win(game, pokemon_locations):
    """
    Check whether the player has won the game.
    The player wins the game by correctly flagging all cells with hidden Pokemon
    AND exposing all cells that do not contain Pokemon.

    :type game: object
    :param game: game string (str)
    :param pokemon_locations: indexes of pokemon locations (tuple<int, ...>)
    :return: True: if the player wins
             False: if the player has not won yet
    """
    if UNEXPOSED in game:
        return False
    elif game.count(FLAG) != len(pokemon_locations):
        return False
    else:
        for item in pokemon_locations:
            if game[item] != FLAG:
                return False
        return True


def main():
    """
    Verify input actions including Restart, Help and Quit

    Inputs: grid size of the game
            number of pokemons
    :return: None
    """
    grid_size = int(input("Please input the size of the grid: "))
    number_of_pokemons = int(input("Please input the number of pokemons: "))
    game = UNEXPOSED * grid_size ** 2
    pokemon_locations = generate_pokemons(grid_size, number_of_pokemons)
    while not check_win(game, pokemon_locations):
        display_game(game, grid_size)
        print()
        action = input("Please input action: ")
        if action == ':)':
            print("It's rewind time.")
            game = UNEXPOSED * grid_size ** 2
            pokemon_locations = generate_pokemons(grid_size, number_of_pokemons)
        elif action == 'q':
            confirm = input("You sure about that buddy? (y/n): ")
            if confirm == 'n':
                print("Let's keep going.")
            elif confirm == 'y':
                print("Catch you on the flip side.")
                return
            else:
                print(INVALID)
        elif action == 'h':
            print(HELP_TEXT)
        elif action[:2] == 'f ':
            position = parse_position(action[2:], grid_size)
            if position is not None:
                index = position_to_index(position, grid_size)
                game = flag_cell(game, index)
            else:
                print(INVALID)
        else:
            position = parse_position(action, grid_size)
            if position is not None:
                index = position_to_index(position, grid_size)
                character = number_at_cell(game, pokemon_locations, grid_size, index)
                if character == FLAG:
                    pass
                elif character is None:
                    for index in pokemon_locations:
                        game = game[: index] + UNEXPOSED + game[index + 1:]
                        game = replace_character_at_index(game, index, POKEMON)
                    display_game(game, grid_size)
                    print('You have scared away all the pokemons.')
                    return
                else:
                    game = replace_character_at_index(game, index, character)
                    search_result = big_fun_search(game, grid_size, pokemon_locations, index)
                    for index in search_result:
                        character = number_at_cell(game, pokemon_locations, grid_size, index)
                        game = replace_character_at_index(game, index, character)
            else:
                print(INVALID)

    display_game(game, grid_size)
    print("You win.")




def big_fun_search(game, grid_size, pokemon_locations, index):
    """Searching adjacent cells to see if there are any Pokemon"s present.

    Using some sick algorithms.

    Find all cells which should be revealed when a cell is selected.

    For cells which have a zero value (i.e. no neighbouring pokemons) all the cell"s
    neighbours are revealed. If one of the neighbouring cells is also zero then
    all of that cell"s neighbours are also revealed. This repeats until no
    zero value neighbours exist.

    For cells which have a non-zero value (i.e. cells with neighbour pokemons), only
    the cell itself is revealed.

    Parameters:
        game (str): Game string.
        grid_size (int): Size of game.
        pokemon_locations (tuple<int, ...>): Tuple of all Pokemon's locations.
        index (int): Index of the currently selected cell

    Returns:
        (list<int>): List of cells to turn visible.
    """
    queue = [index]
    discovered = [index]
    visible = []

    if game[index] == FLAG:
        return queue

    number = number_at_cell(game, pokemon_locations, grid_size, index)
    if number != 0:
        return queue

    while queue:
        node = queue.pop()
        for neighbour in neighbour_directions(node, grid_size):
            if neighbour in discovered or neighbour is None:
                continue

            discovered.append(neighbour)
            if game[neighbour] != FLAG:
                number = number_at_cell(game, pokemon_locations, grid_size, neighbour)
                if number == 0:
                    queue.append(neighbour)
            visible.append(neighbour)
    return visible


if __name__ == "__main__":
    main()
