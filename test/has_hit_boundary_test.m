% add folders to path
folders_to_be_added = genpath(pwd);
addpath(folders_to_be_added );

% create the game display
s = [800 600];
bc = 'white'; % 'black';
bi = 'img/white.png'; % 'background_test.png'; % 
rcs = 1;
game_one = display_game(s, bc, bi, rcs);
h_game = show_game_board(game_one);

% i will kill you
pause(0.5);



% create bullet
ib = 'img/bullet.jpg'; % image
pb = [350 350]; % position
db = [0 0]; % direction
sb = .035; % size
fb = 0; % flag
bullet = Bullet(ib, pb, db, sb, fb);

% initialize bullet sequence
bullet_sequence_order = 0;

% initialize bullet container
bullets = {};
h_bullets = {}; % initialize container for bullets' handles
max_num_bullets = 1; 

bullet.position(1) = 0;

bullet.has_hit_boundary
