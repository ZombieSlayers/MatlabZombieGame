function zombie_game 
% ZOMBIE_GAME executes the game.

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
    [iwillkillyousound, iwky_frames_per_second] = audioread('sounds/iwillkillyou.mp3');
    sound(iwillkillyousound, iwky_frames_per_second);
    pause(0.5);

    % create one zombie
    iz = 'img/zombie.jpg'; % image
    pz = [150 150]; % position
    dz = [0 0]; % direction
    sz = .05; % size
    zombie_one = Zombies(iz, pz, dz, sz);
    h_zombie = zombie_one.zombie_on_game_board; % handle of the image


    % create Rick
    ir = 'img/rickgrimes2.jpg'; % image
    pr = [650 150]; % position
    dr = [0 0]; % direction
    sr = .2; % size
    rickgrimes = Rick(ir, pr, dr, sr);
    h_rick = rickgrimes.rick_on_game_board; % handle of the image

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
    max_num_bullets = 3; 


    % initialize exit flag to zero
    exit_flag = 0;
    time = 0;
    zombie_one_random_direction = 0;
    state_zombie_one = 1;
    win_flag = 0; % becomes 1 if you kill the zombie, stays zero if the zombie kills you


    %% GAME LOOP
    while exit_flag == 0  

        % the zombie moves back and ahead on the screen
        state_zombie_one = zombie_one.move_back_and_ahead_only(state_zombie_one, game_one); 
        h_zombie.Visible = 'off';    
        h_zombie = zombie_one.zombie_on_game_board;
        
        
        % Rick moves depending on the keyboard key pressed
        rickgrimes.move(h_game);
        rickgrimes.has_hit_boundary;
        h_rick.Visible = 'off';
        h_rick = rickgrimes.rick_on_game_board;
 

        % bullets already existing keep moving
        i_bullet = 1; % initialize the index for first bullet
        while i_bullet <= bullet_sequence_order 
            bullets{i_bullet}.simple_shooting(h_game, zombie_one, rickgrimes);
            h_bullets{i_bullet}.Visible = 'off';
            h_bullets{i_bullet} = bullets{i_bullet}.bullet_on_game_board;

            % if zombie has been hit
            if bullets{i_bullet}.position(1) <= zombie_one.position(1) + 60    && bullets{i_bullet}.position(2) >= zombie_one.position(2) - 20 && bullets{i_bullet}.position(2) <= zombie_one.position(2) + 20
                
                h_boom = game_one.zombie_hit(zombie_one, bullets{i_bullet}, 0.1); % display the explosion image
                h_zombie.Visible = 'off';
                exit_flag = 1;
                win_flag = 1;
                bullets = {}; % delete all bullets
                
            end
            
            if ~isempty(bullets) && bullets{i_bullet}.has_hit_boundary(game_one) == 1 % if there still are bullets and one of them hits the boundary
                
                h_bullet_boom = game_one.bullet_explodes(bullets{i_bullet}, 0.05); % bullet explodes
                h_bullet_boom.Visible = 'off';
                h_bullets{i_bullet}.Visible = 'off';
                clear bullets{i_bullet};
                bullets = {bullets{1:i_bullet-1}, bullets{i_bullet+1:end}}; % delete the bullet that hit the boundary
                bullet_sequence_order = bullet_sequence_order - 1; 
            else
                i_bullet = i_bullet + 1; % go to next bullet
            end

        end

        % rick gets killed
        if rickgrimes.position(1) <= zombie_one.position(1) + 100 && rickgrimes.position(1) >= zombie_one.position(1) - 100 && rickgrimes.position(2) >= zombie_one.position(2) - 100 && rickgrimes.position(2) <= zombie_one.position(2) + 100 
            h_rick.Visible = 'off'; 
            h_zombie.Visible = 'off';
            game_one.rick_killed(zombie_one, rickgrimes, 0.2); 
            [deathsound, death_frames_per_second] = audioread('sounds/death.mp3');
            sound(deathsound, death_frames_per_second);
            exit_flag = 1;
        end

        % new bullet shot
        if strcmp(h_game.CurrentKey, 'space') && bullet_sequence_order < max_num_bullets % && new_bullet_flag == 0
                bullet_sequence_order = bullet_sequence_order + 1; % add a new instances of bullet                
                bullets{bullet_sequence_order} = Bullet(ib, rickgrimes.position, db, sb, fb); % create new bullet and add it to the list of bullets

                bullets{bullet_sequence_order}.simple_shooting(h_game, zombie_one, rickgrimes);            
                % bullets{bullet_sequence_order}.shooting(h_game, zombie_one, rickgrimes);
                h_bullets{bullet_sequence_order}.Visible = 'off';
                h_bullets{bullet_sequence_order} = bullets{bullet_sequence_order}.bullet_on_game_board; % create handle for this new bulllet
                bullets{bullet_sequence_order}.flag = 1;     
        end



        pause(.01);

    end

    % display end game
    pause(2);
    game_one.end_game(h_game, win_flag);

    rmpath(folders_to_be_added);

end