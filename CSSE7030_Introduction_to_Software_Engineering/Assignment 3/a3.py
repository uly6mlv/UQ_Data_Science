import random
import tkinter as tk
from tkinter import messagebox
from tkinter import filedialog
import os.path
from os import path
from tkinter import simpledialog
from PIL import Image, ImageTk

ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
UP = "up"
DOWN = "down"
LEFT = "left"
RIGHT = "right"
DIRECTIONS = (UP, DOWN, LEFT, RIGHT,
              f"{UP}-{LEFT}", f"{UP}-{RIGHT}",
              f"{DOWN}-{LEFT}", f"{DOWN}-{RIGHT}")
POKEMON = "p"
FLAG = "f"
UNEXPOSED = "~"
EXPOSED = "0"
TASK_ONE = 'TASK_ONE'
TASK_TWO = 'TASK_TWO'


class BoardModel(object):
    """
    Game Model, storing information of the game
    """
    def __init__(self, grid_size, num_pokemon):
        """
        Construct the model
        :param grid_size: width and height of the game (int)
        :param num_pokemon: number of pokemons (int)
        """
        self._grid_size = grid_size
        self._num_pokemon = num_pokemon
        self._game = UNEXPOSED * grid_size ** 2
        self._pokemon_locations = self.generate_pokemons()

    def generate_pokemons(self):
        """
        Generate pokemon locations
        :return: pokemon_locations (tuple<int...>)
        """
        cell_count = self._grid_size ** 2
        pokemon_locations = ()

        for _ in range(self._num_pokemon):
            if len(pokemon_locations) >= cell_count:
                break
            index = random.randint(0, cell_count - 1)

            while index in pokemon_locations:
                index = random.randint(0, cell_count - 1)

            pokemon_locations += (index,)
        return pokemon_locations

    def position_to_index(self, position):
        """
        Converts position to index
        :param position: position of a grid (tuple<int, int>)
        :return: index (int)
        """
        return position[1] + position[0] * self._grid_size

    def replace_character_at_index(self, index, character):
        """
        Replace the game string at the given index
        :param index: location index (int)
        :param character: character to replece with (str)
        :return: None
        """
        self._game = self._game[:index] + str(character) + self._game[index + 1:]

    def flag_cell(self, index):
        """
        Flag or unflag a cell
        :param index: location index (int)
        :return: None
        """
        if self._game[index] == UNEXPOSED:
            self.replace_character_at_index(index, FLAG)
        elif self._game[index] == FLAG:
            self._game = self._game[:index] + UNEXPOSED + self._game[index + 1:]

    def index_in_direction(self, index, direction):
        """
        Find index from a cell at the given index and direction
        :param index: location index (int)
        :param direction:  (str)
        :return: index (int) or None
        """
        row, col = index // self._grid_size, index % self._grid_size
        if UP in direction:
            row -= 1
        if DOWN in direction:
            row += 1
        if LEFT in direction:
            col -= 1
        if RIGHT in direction:
            col += 1
        if (row >= self._grid_size) | (col >= self._grid_size) | (row < 0) | (col < 0):
            return
        else:
            return self.position_to_index((row, col))

    def neighbour_directions(self, index):
        """
        Find out all possible directions with neighbour cells at the give index
        :param index: location index (int)
        :return: list of directions (list<str>)
        """
        lst = []
        for direction in DIRECTIONS:
            lst.append(self.index_in_direction(index, direction))
        lst = list(filter(None.__ne__, lst))
        return lst

    def number_at_cell(self, index):
        """
        Find out number of pokemons surrounding a cell at the give index
        :param index: location index (int)
        :return: count (int)
        """
        if self._game[index] == FLAG:
            return FLAG
        elif index in self._pokemon_locations:
            return
        count = 0
        for neighbour in self.neighbour_directions(index):
            if neighbour in self._pokemon_locations:
                count += 1
        return count

    def reveal_cells(self, index):
        """
        Reveals all neighbouring cells at index and repeats for all
        cells that had a 0.

        Does not reveal flagged cells or cells with Pokemon.
        :param index: location index (int)
        :return: None
        """
        number = self.number_at_cell(index)
        self.replace_character_at_index(index, str(number))
        clear = self.big_fun_search(index)
        for i in clear:
            if self._game[i] != FLAG:
                number = self.number_at_cell(i)
                self.replace_character_at_index(i, str(number))

    def big_fun_search(self, index):
        """
        Searching adjacent cells to see if there are any Pokemon"s present.
        Using some sick algorithms.

        Find all cells which should be revealed when a cell is selected.

        For cells which have a zero value (i.e. no neighbouring pokemons) all the cell"s
        neighbours are revealed. If one of the neighbouring cells is also zero then
        all of that cell"s neighbours are also revealed. This repeats until no
        zero value neighbours exist.

        For cells which have a non-zero value (i.e. cells with neighbour pokemons), only
        the cell itself is revealed.
        :param index: location index(int)
        :return: List of cells to turn visible (list<int>)
        """
        queue = [index]
        discovered = [index]
        visible = []

        if self._game[index] == FLAG:
            return queue

        number = self.number_at_cell(index)
        if number != 0:
            return queue

        while queue:
            node = queue.pop()
            for neighbour in self.neighbour_directions(node):
                if neighbour in discovered or neighbour is None:
                    continue

                discovered.append(neighbour)
                if self._game[neighbour] != FLAG:
                    number = self.number_at_cell(neighbour)
                    if number == 0:
                        queue.append(neighbour)
                visible.append(neighbour)
        return visible

    def get_game(self):
        """
        Get game string (str)
        :return: game string (str)
        """
        return self._game

    def get_pokemon_locations(self):
        """
        Get pokemon locations
        :return: pokemon locations (tuple<int>)
        """
        return self._pokemon_locations

    def get_num_attempted_catches(self):
        """
        Get number of flags or pokeballs used
        :return: number of flags or pokeballs used (int)
        """
        return self._game.count(FLAG)

    def get_grid_size(self):
        """
        Get grid size
        :return: grid size (int)
        """
        return self._grid_size

    def get_num_pokemon(self):
        """
        Get number of pokemons
        :return: number of pokemons (int)
        """
        return self._num_pokemon

    def check_loss(self):
        """
        Check whether the player loses
        :return: True or None
        """
        if POKEMON in self._game:
            return True

    def check_win(self):
        """
        Check whether the player wins
        :return: True or False
        """
        return UNEXPOSED not in self._game and self._game.count(FLAG) == len(self._pokemon_locations)


class PokemonGame:
    """
    The control class
    """
    def __init__(self, master, grid_size=10, num_pokemon=15, task=TASK_TWO):
        """
        Construct the game control class
        :param master: main window
        :param grid_size: width and height of the game (int)
        :param num_pokemon: number of pokemons (int)
        :param task: task type (TASK_ONE or TASK_TWO)
        """
        self._master = master
        master.title("Pokemon: Got 2 Find Them All!")
        self._label = tk.Label(master, text="Pokemon: Got 2 Find Them All!", font="Courier 23 bold",
                               fg="white", bg="indian red")
        self._label.pack(side=tk.TOP, fill=tk.X)
        self._grid_size = grid_size
        self._num_pokemon = num_pokemon
        self._task = task
        self._model = BoardModel(grid_size, num_pokemon)
        if self._task == TASK_ONE:
            self._view = BoardView(master, self._grid_size)
            self._view.bind("<Motion>", self.motion1)
            self._view.draw_board(self._model.get_game())
            self._view.pack()
        elif self._task == TASK_TWO:
            menubar = tk.Menu(self._master)
            self._master.config(menu=menubar)
            filemenu = tk.Menu(menubar)
            menubar.add_cascade(label="File", menu=filemenu)
            filemenu.add_command(label="High scores", command=self.high_scores)
            filemenu.add_command(label="Save game", command=self.save_game)
            filemenu.add_command(label="Load game", command=self.load_game)
            filemenu.add_command(label="Restart game", command=self.restart_game)
            filemenu.add_command(label="New game", command=self.new_game)
            filemenu.add_command(label="Quit", command=self.quit)
            self._filename = None
            self._state = False
            self._view = ImageBoardView(master, self._grid_size)
            self._view.draw_board(self._model.get_game())
            self._view.bind("<Motion>", self.motion2)
            self._view.pack()
            self._statusbar = StatusBar(master, self._model, self._view)
            self._statusbar.pack()

        self._view.bind("<Button-1>", self.left_click)
        self._view.bind("<Button-2>", self.right_click)
        self._view.bind("<Button-3>", self.right_click)

    def motion1(self, e):
        """
        TASK_ONE only
        To highlight the square with a red boarder while the cursor is on it
        :param e: pixel the cursor is on (tuple<int,int>)
        :return: None
        """
        position = self._view.pixel_to_position((e.x, e.y))
        pixel = self._view.position_to_pixel(position)
        bbox = self._view.get_bbox(pixel)
        self._view.draw_board(self._model.get_game())
        self._view.create_rectangle(bbox, outline='red')
        self._view.pack()

    def motion2(self, e):
        """
        TASK_TWO only
        To make the tall grass rustle while the cursor is on it
        :param e: pixel the cursor is on (tuple<int,int>)
        :return: None
        """
        position = self._view.pixel_to_position((e.x, e.y))
        pixel = self._view.position_to_pixel(position)
        index = self._model.position_to_index(position)
        if index >= self._grid_size ** 2:
            return
        if self._model.get_game()[index] == UNEXPOSED:
            self._view.draw_board(self._model.get_game())
            self._view.create_image(pixel, image=self._view.images['unrevealed_moved'])
            self._view.pack()

    def high_scores(self):
        """
        Show top 3 high scores
        :return: None
        """
        top = tk.Toplevel(width=80, height=100)
        top.title("Top3")
        label = tk.Label(top, text="High Scores", fg="white", bg="indian red", font="Courier 12 bold")
        label.pack(fill=tk.X)
        if path.exists('high_scores.txt'):
            fd = open('high_scores.txt', 'r')
            lines = fd.readlines()
            fd.close()
            text = ""
            for line in lines:
                text = text + line
            msg = tk.Message(top, text=text)
            msg.pack()
        button = tk.Button(top, text="Done", command=top.destroy)
        button.pack()

    def save_game(self):
        """
        Save the game progress
        :return: None
        """
        filename = filedialog.asksaveasfilename()
        if filename:
            self._filename = filename
        if self._filename:
            fd = open(self._filename, 'w')
            fd.write(f'{self._model.get_game()}\n{self._model.get_pokemon_locations()}\n{self._statusbar.sec}\n'
                     f'{self._statusbar.min}')
            fd.close()

    def load_game(self):
        """
        Load a game progress
        :return: None
        """
        filename = filedialog.askopenfilename()
        if filename:
            self._filename = filename
            fd = open(filename, 'r')
            lines = fd.readlines()
            self._model._game = lines[0]
            self._model._pokemon_locations = eval(lines[1])
            self._statusbar.sec = int(lines[2])
            self._statusbar.min = int(lines[3])
            fd.close()
            self._view.draw_board(self._model.get_game())
            self._view.pack()

    def restart_game(self):
        """
        Restart the game while pokemon locations are unchanged
        :return: None
        """
        self._statusbar.restart_game()

    def new_game(self):
        """
        Start a new game with new pokemon locations
        :return: None
        """
        self._statusbar.new_game()

    def quit(self):
        """
        Quit game
        :return: None
        """
        ans = messagebox.askokcancel("Verify exit", "Really quit?")
        if ans:
            self._master.destroy()

    def high_score_prompt(self):
        """
        Prompt a window for players to enter their names if they have achieved Top 3 high scores
        :return: None
        """
        self._statusbar.doTick = False
        if self._statusbar.sec < 10:
            sec_str = '0' + str(self._statusbar.sec)
        else:
            sec_str = self._statusbar.sec
        new_record = int(f'{self._statusbar.min}{sec_str}')
        if not path.exists('high_scores.txt'):
            ans = simpledialog.askstring('You Win!', f'You won in {self._statusbar.min}m and {self._statusbar.sec}s! '
                                                     f'Enter your name')
            fd = open('high_scores.txt', 'w')
            if self._statusbar.min == 0:
                fd.write(f'{ans}: {self._statusbar.sec}s')
            else:
                fd.write(f'{ans}: {self._statusbar.min}m {self._statusbar.sec}s')
            fd.close()
            fd = open('score_values.txt', 'w')
            fd.write(str(new_record))
            fd.close()
        else:
            fd1 = open('score_values.txt', 'r')
            sv_lines = fd1.readlines()
            fd1 = open('score_values.txt', 'w')
            fd2 = open('high_scores.txt', 'r')
            hs_lines = fd2.readlines()
            fd2 = open('high_scores.txt', 'w')
            for index, element in enumerate(sv_lines):
                if new_record <= int(element.rstrip()):
                    ans = simpledialog.askstring('You Win!',
                                                 f'You won in {self._statusbar.min}m and {self._statusbar.sec}s! '
                                                 f'Enter your name')
                    sv_lines.insert(index, str(new_record))
                    if self._statusbar.min == 0:
                        hs_lines.insert(index, f'{ans}: {self._statusbar.sec}s')
                    else:
                        hs_lines.insert(index, f'{ans}: {self._statusbar.min}m {self._statusbar.sec}s')
                    if len(sv_lines) > 3:
                        sv_lines.pop()
                        hs_lines.pop()
                    for line in sv_lines:
                        fd1.write(f'{line.rstrip()}\n')
                    for line in hs_lines:
                        fd2.write(f'{line.rstrip()}\n')
                    fd1.close()
                    fd2.close()
                    return
            if len(sv_lines) < 3:
                ans = simpledialog.askstring('You Win!',
                                             f'You won in {self._statusbar.min}m and {self._statusbar.sec}s! '
                                             f'Enter your name')
                sv_lines.append(str(new_record))
                if self._statusbar.min == 0:
                    hs_lines.append(f'{ans}: {self._statusbar.sec}s')
                else:
                    hs_lines.append(f'{ans}: {self._statusbar.min}m {self._statusbar.sec}s')
                for line in sv_lines:
                    fd1.write(f'{line.rstrip()}\n')
                for line in hs_lines:
                    fd2.write(f'{line.rstrip()}\n')
                fd1.close()
                fd2.close()

    def left_click(self, e):
        """
        Left click action
        Reveal an unexposed cell
        :param e: pixel the the mouse left clicks
        :return: None
        """
        position = self._view.pixel_to_position((e.x, e.y))
        index = self._model.position_to_index(position)
        if index >= self._grid_size ** 2:
            return
        if self._model.get_game()[index] == FLAG:
            return
        elif index in self._model.get_pokemon_locations():
            for i in self._model.get_pokemon_locations():
                self._model._game = self._model.get_game()[:i] + POKEMON + self._model.get_game()[i + 1:]
        else:
            self._model.reveal_cells(index)
        if self._task == TASK_ONE:
            self._view.draw_board(self._model.get_game())
            self._view.pack()
            if self._model.check_loss():
                messagebox.showinfo("Game Over", "You lost! :(")
                self._master.destroy()
            elif self._model.check_win():
                messagebox.showinfo("Congrats", "You win! :D")
                self._master.destroy()
        elif self._task == TASK_TWO:
            self._view.draw_board(self._model.get_game())
            self._view.pack()
            if self._model.check_loss():
                self._statusbar.doTick = False
                ans = messagebox.askyesno("Game Over", "You lose! Would you like to play again?")
                if ans:
                    self._statusbar.doTick = True
                    self._statusbar.new_game()
                    self._statusbar.timer()
                else:
                    self._master.destroy()
            elif self._model.check_win():
                self.high_score_prompt()
                self.task_two_win()

    def right_click(self, e):
        """
        Right click action
        Flag or unflag a cell
        :param e: pixel the the mouse right clicks
        :return: None
        """
        position = self._view.pixel_to_position((e.x, e.y))
        index = self._model.position_to_index(position)
        if index >= self._grid_size ** 2:
            return
        if self._task == TASK_ONE:
            self._model.flag_cell(index)
            self._view.draw_board(self._model.get_game())
            self._view.pack()
            if self._model.check_win():
                messagebox.showinfo("Congrats", "You win! :D")
                self._master.destroy()
        elif self._task == TASK_TWO:
            if (self._statusbar.num_pokeball_left() == 0) & (self._model.get_game()[index] != FLAG):
                return
            self._model.flag_cell(index)
            self._view.draw_board(self._model.get_game())
            self._view.pack()
            self._statusbar.update_text()
            if self._model.check_win():
                self.high_score_prompt()
                self.task_two_win()

    def task_two_win(self):
        """
        TASK_TWO only
        Prompt a message box asking the player whether to play again
        :return: None
        """
        ans = messagebox.askyesno("Congrats", "You win! Would you like to play again?")
        if ans:
            self._statusbar.doTick = True
            self._statusbar.new_game()
            self._statusbar.timer()
        else:
            self._master.destroy()


class BoardView(tk.Canvas):
    """
    TASK_ONE only
    View class of the game
    """
    def __init__(self, master, grid_size, board_width=600, *args, **kwargs):
        """
        Construct the view class
        :param master: main window
        :param grid_size: width and height of the game (int)
        :param board_width: width of the game board (int)
        :param args: additional arguments
        :param kwargs: additional key word arguments
        """
        super().__init__(master,  *args, **kwargs)
        self._grid_size = grid_size
        self._board_width = board_width
        self.config(width=self._board_width, height=self._board_width)
        self._grid_width = self._board_width // self._grid_size

    def draw_board(self, board):
        """
        TASK_ONE only
        Draw the game board
        :param board: game string from the game model (str)
        :return: None
        """
        self.delete(tk.ALL)
        for y in range(self._grid_size):
            x = 0
            for char in board[:self._grid_size]:
                if char == UNEXPOSED:
                    self.create_rectangle(x * self._grid_width, y * self._grid_width, (x + 1) * self._grid_width,
                                          (y + 1) * self._grid_width, fill="dark green")
                elif char == FLAG:
                    self.create_rectangle(x * self._grid_width, y * self._grid_width, (x + 1) * self._grid_width,
                                          (y + 1) * self._grid_width, fill="red")
                elif char == POKEMON:
                    self.create_rectangle(x * self._grid_width, y * self._grid_width, (x + 1) * self._grid_width,
                                          (y + 1) * self._grid_width, fill="yellow")
                else:
                    self.create_rectangle(x * self._grid_width, y * self._grid_width, (x + 1) * self._grid_width,
                                          (y + 1) * self._grid_width, fill="light green")
                    self.create_text((x + 0.5) * self._grid_width, (y + 0.5) * self._grid_width, text=char)
                x += 1
            board = board[self._grid_size:]

    def get_bbox(self, pixel):
        """
        Get the bounding box for a cell centred at the provided pixel
        :param pixel: centred pixel of the cell (tuple<int, int>)
        :return: pixels at the upper-left and lowe-right corners of the cell (tuple<int,int,int,int>)
        """
        return pixel[0] - self._grid_width/2, pixel[1] - self._grid_width/2, \
            pixel[0] + self._grid_width/2, pixel[1] + self._grid_width/2

    def position_to_pixel(self, position):
        """
        Converts a cell position to its centred pixel
        :param position: position of a cell (tuple<int, int>)
        :return: pixel (tuple<int, int>)
        """
        return self._grid_width * (position[1] + 0.5), self._grid_width * (position[0] + 0.5)

    def pixel_to_position(self, pixel):
        """
        Convert a pixel to the position of the cell
        :param pixel: input pixel (tuple<int, int>)
        :return: position (tuple<int, int>)
        """
        return int(pixel[1] // self._grid_width), int(pixel[0] // self._grid_width)


class StatusBar(tk.Frame):
    """
    Status bar showing info of time, pokeballs, a new game button and a restart game button
    """
    def __init__(self, master, model, view):
        """
        Contruct the status bar
        :param master: main window
        :param model: game model class
        :param view: game view class
        """
        super().__init__(master)
        self.config(width=600, height=70)
        self.pack_propagate(0)
        self._model = model
        self._view = view
        self.img_label_pokeball = tk.Label(self)
        self.img_label_pokeball.image = tk.PhotoImage(file="images/full_pokeball.gif")
        self.img_label_pokeball['image'] = self.img_label_pokeball.image

        self._frame_1 = tk.Frame(self)

        self.label_attempted_text = f'{self._model.get_num_attempted_catches()} attempted catches'
        self.label_attempted = tk.Label(self._frame_1, text=self.label_attempted_text)

        self.label_left_text = f'{self.num_pokeball_left()} pokeballs left'
        self.label_left = tk.Label(self._frame_1, text=self.label_left_text)

        self.img_label_clock = tk.Label(self)
        self.img_label_clock.image = tk.PhotoImage(file="images/clock.gif")
        self.img_label_clock['image'] = self.img_label_clock.image

        self.label_timer = tk.Label(self, text="")
        self._frame_2 = tk.Frame(self)

        self.button_1 = tk.Button(self._frame_2, text='New game', command=self.new_game)
        self.button_2 = tk.Button(self._frame_2, text='Restart game', command=self.restart_game)

        self.img_label_pokeball.pack(side=tk.LEFT, expand=1, anchor=tk.E)
        self._frame_1.pack(side=tk.LEFT, expand=1, anchor=tk.W)
        self.label_attempted.pack(expand=1, anchor=tk.W)
        self.label_left.pack(expand=1, anchor=tk.W)
        self.img_label_clock.pack(side=tk.LEFT, expand=1, anchor=tk.E)
        self.label_timer.pack(side=tk.LEFT, expand=1, anchor=tk.W)
        self._frame_2.pack(side=tk.RIGHT, expand=1, anchor=tk.W)
        self.button_1.pack()
        self.button_2.pack()

        self.doTick = True
        self.sec = -1
        self.min = 0
        self.timer()

    def update_text(self):
        """
        Update numbers of pokeballs used and left
        :return: None
        """
        self.label_attempted_text = f'{self._model.get_num_attempted_catches()} attempted catches'
        self.label_left_text = f'{self.num_pokeball_left()} pokeballs left'
        self.label_attempted.config(text=self.label_attempted_text)
        self.label_left.config(text=self.label_left_text)
        if self.num_pokeball_left() == 0:
            self.img_label_pokeball.image = tk.PhotoImage(file="images/empty_pokeball.gif")
        else:
            self.img_label_pokeball.image = tk.PhotoImage(file="images/full_pokeball.gif")
        self.img_label_pokeball['image'] = self.img_label_pokeball.image

    def new_game(self):
        """
        Start a new game with new pokemon locations
        :return: None
        """
        self._model._pokemon_locations = self._model.generate_pokemons()
        self._model._game = UNEXPOSED * self._model.get_grid_size() ** 2
        self._view.draw_board(self._model.get_game())
        self._view.pack()
        self.sec = -1
        self.min = 0
        self.update_text()

    def restart_game(self):
        """
        Restart the game while pokemon locations are unchanged
        :return: None
        """
        self._model._game = UNEXPOSED * self._model.get_grid_size() ** 2
        self._view.draw_board(self._model.get_game())
        self._view.pack()
        self.sec = -1
        self.min = 0
        self.update_text()

    def timer(self):
        """
        Build a timer to record the game time
        :return: None
        """
        if not self.doTick:
            return
        self.sec += 1
        if self.sec == 60:
            self.min += 1
            self.sec = 0
        time = f'Time elapsed\n{self.min}m {self.sec}s'
        self.label_timer.configure(text=time)
        # Take advantage of the after method of the Label
        self.after(1000, self.timer)

    def num_pokeball_left(self):
        """
        Get the number of pokeballs left
        :return: number of pokeballs left (int)
        """
        return self._model.get_num_pokemon() - self._model.get_num_attempted_catches()


class ImageBoardView(BoardView):
    """
    TASK_TWO only
    View class of the game with images
    """
    def __init__(self, master, grid_size, *args, **kwargs):
        """
        Construct the view class
        :param master: main window
        :param grid_size: width and height of the game (int)
        :param args: additional arguments
        :param kwargs: additional key word arguments
        """
        super().__init__(master,  grid_size, *args, **kwargs)

        self._pokemon_list = ['charizard', 'cyndaquil', 'pikachu', 'psyduck', 'togepi', 'umbreon']
        self.images = {'pokeball': self.load_image('images/pokeball.png'),
                       '0': self.load_image('images/zero_adjacent.png'),
                       '1': self.load_image('images/one_adjacent.png'),
                       '2': self.load_image('images/two_adjacent.png'),
                       '3': self.load_image('images/three_adjacent.png'),
                       '4': self.load_image('images/four_adjacent.png'),
                       '5': self.load_image('images/five_adjacent.png'),
                       '6': self.load_image('images/six_adjacent.png'),
                       '7': self.load_image('images/seven_adjacent.png'),
                       '8': self.load_image('images/eight_adjacent.png'),
                       'charizard': self.load_image('images/pokemon_sprites/charizard.png'),
                       'cyndaquil': self.load_image('images/pokemon_sprites/cyndaquil.png'),
                       'pikachu': self.load_image('images/pokemon_sprites/pikachu.png'),
                       'psyduck': self.load_image('images/pokemon_sprites/psyduck.png'),
                       'togepi': self.load_image('images/pokemon_sprites/togepi.png'),
                       'umbreon': self.load_image('images/pokemon_sprites/umbreon.png'),
                       'unrevealed': self.load_image('images/unrevealed.png'),
                       'unrevealed_moved': self.load_image('images/unrevealed_moved.png')}

    def load_image(self, image):
        """
        Load the image from the given directory
        :param image: directory of the image (str)
        :return: the code for loading image
        """
        return ImageTk.PhotoImage(Image.open(image).resize((self._grid_width, self._grid_width), Image.ANTIALIAS))

    def draw_board(self, board):
        """
        Draw a game board with images
        :param board: game string from the game model (str)
        :return: None
        """
        self.delete(tk.ALL)
        for y in range(self._grid_size):
            x = 0
            for char in board[:self._grid_size]:
                if char == UNEXPOSED:

                    self.create_image(self._grid_width * (x + 0.5), self._grid_width * (y + 0.5),
                                      image=self.images['unrevealed'])
                elif char == FLAG:
                    self.create_image(self._grid_width * (x + 0.5), self._grid_width * (y + 0.5),
                                      image=self.images['pokeball'])
                elif char == POKEMON:
                    self.create_image(self._grid_width * (x + 0.5), self._grid_width * (y + 0.5),
                                      image=self.images[self._pokemon_list[random.randint(0, 5)]])
                else:
                    self.create_image(self._grid_width * (x + 0.5), self._grid_width * (y + 0.5),
                                      image=self.images[char])
                x += 1
            board = board[self._grid_size:]
        self.pack()


def main():
    """
    None
    :return: None
    """
    root = tk.Tk()
    root.title("Game")

    PokemonGame(root)

    root.update()
    root.mainloop()


if __name__ == "__main__":
    main()
