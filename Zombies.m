classdef Zombies < handle
    properties 
        image;
        position;
        direction;
        size;

    end
    methods
        % constructor 
        function obj = Zombies(i, p, d, s)
            obj.image = i;
            obj.position = p;
            obj.direction = d;
            obj.size = s;
        end

        % put it in the game
        function handle_image = zombie_on_game_board(obj)
        % ZOMBIE_ON_GAME_BOARD plots the zombie image on the game boardupdate
            zombie_image = imread(obj.image);
            zombie_image = imresize(zombie_image, obj.size);
            handle_image = image(obj.position(1) , ...
                obj.position(2), ...
                zombie_image);
        end

        % movements
        function move_ahead(obj)
            obj.position = obj.position + [0 10];
            % obj.has_hit_boundary; % make sure it is in the boundary of the screen game            
        end

        function move_back(obj)
            obj.position = obj.position + [0 -10];            
            % obj.has_hit_boundary; % make sure it is in the boundary of the screen game        
        end

        function move_right(obj)
            obj.position = obj.position + [10 0];  
            % obj.has_hit_boundary; % make sure it is in the boundary of the screen game          
        end

        function move_left(obj)
            obj.position = obj.position + [-10 0];  
            % obj.has_hit_boundary; % make sure it is in the boundary of the screen game          
        end
                

        % moving up and down only
        function state = move_back_and_ahead_only(obj, state, game_obj)
            % move_back_and_ahead_only makes the zombie move up and down on the screen
            % inputs:
            %   obj: instance of the class Zombies
            %   state: 1 if moving ahead in the previous step, 0 if moving backwards

            if state == 1 % start with going ahead
                hb_flag = obj.has_hit_boundary(game_obj);
                
                if hb_flag == 4
                    obj.move_back;
                    state = 0;
                else
                    obj.move_ahead;
                end

            elseif state == 0
                hb_flag = obj.has_hit_boundary(game_obj);
                
                if hb_flag == 3
                    obj.move_ahead;
                    state = 1;
                else
                    obj.move_back;
                end
            end

        end

        % hitting boundary check
        function flag = has_hit_boundary(obj, game_obj)
        % HAS_HIT_BOUNDARY deals with hitting boundary. It sets a flag that is then used in the method move_back_and_ahead_only as a signal which boundary has been hit
            flag = 0;
            if obj.position(1)<0
                % obj.position(1) = 0;
                flag = 1;
            end
            if obj.position(1)>game_obj.size(1)
                % obj.position(1) = 800;
                flag = 2;
            end
            if obj.position(2)<0
                % obj.position(2) = 0;
                flag = 3;
            end
            if obj.position(2)>game_obj.size(2)
                % obj.position(2) = 800;
                flag = 4;
            end
            
            
        end                

    end
end