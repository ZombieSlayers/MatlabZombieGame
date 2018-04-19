% create the game display
addpath(genpath('..'));

s = [800 600];
bc = 'white'; % 'black';
bi = 'img/white.png'; % 'background_test.png'; % 
rcs = 1;
game_one = display_game(s, bc, bi, rcs);
h_game = show_game_board(game_one);


game_one.end_game(h_game, 0);

rmpath('..');