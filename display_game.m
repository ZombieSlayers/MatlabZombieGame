classdef display_game
% DISPLAY_GAME creates the game figure and manages explosions
    properties         
        size;
        background_color;
        background_image;
        relative_coordinates_system;

    end

    methods 
        % constructor
        function obj = display_game(s, bc, bi, rcs)
            obj.size = s;
            obj.background_color = bc; 
            obj.background_image = bi;
            obj.relative_coordinates_system = rcs;            
        end

        % method for displaying the game board
        function handle_figure = show_game_board(obj)
            image_data = imread(obj.background_image);
            handle_figure = figure('Color', obj.background_color, ...
                'MenuBar', 'none', ...
                'OuterPosition', [40 40 obj.size] ) ; 
            set(handle_figure,'WindowStyle','modal');
            set(gca,'position',[0 0 1 1],'units','normalized');
            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
            image(image_data);
            axis off;
            hold on;
        end

        % zombie has been hit
        function  handle_image = zombie_hit(obj, zombie_obj, bullet_obj, scale_parameter)            
            boom_image = imread('img/boom.jpg');
            boom_image = imresize(boom_image, scale_parameter );
            handle_image = image(zombie_obj.position(1) + 20  , ...
                zombie_obj.position(2) - 20, ...
                boom_image);
            
        end     

        % bullet explodes
        function  handle_image = bullet_explodes(obj, bullet_obj, scale_parameter)            
            boom_image = imread('img/boom.jpg');
            boom_image = imresize(boom_image, scale_parameter );
            handle_image = image(bullet_obj.position(1) - 10 , ...
                bullet_obj.position(2), ...
                boom_image);
            pause(.1);
            
        end

        % rick is killed
        function  handle_image = rick_killed(obj, zombie_obj, rick_obj, scale_parameter)            
            blood_image = imread('img/blood.png');
            blood_image = imresize(blood_image, scale_parameter );
            handle_image = image(rick_obj.position(1) -30 , ...
                rick_obj.position(2)-30 , ...
                blood_image);
            
        end     

        % end game
        function end_game(obj, handle_figure, win_flag)        
            if win_flag == 1
                obj.background_image = 'img/YouWin.png';
            else
                obj.background_image = 'img/game-over.jpeg';
            end
            set(handle_figure,'WindowStyle','modal');
            set(gca,'position',[0 0 1 1],'units','normalized');
            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
            image_data = imread(obj.background_image);
            image_data = imresize(image_data, [800 1400] );
            image(image_data);
            axis off;
        end
    end
end