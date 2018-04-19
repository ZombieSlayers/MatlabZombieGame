classdef Bullet < handle
% BULLET is a class for managing shooting
    properties
        image
        position
        direction
        size
        flag
    end
    methods
        % constructor
        function obj = Bullet(i, p, d, s, f)
            obj.image = i;
            obj.position = p;
            obj.direction = d;
            obj.size = s;
            obj.flag = f;
        end
        
        % put it in the game
        function handle_image = bullet_on_game_board(obj)
            bullet_image = imread(obj.image); % read image
            bullet_image = imresize(bullet_image, obj.size); % resize image
            bullet_image = imrotate(bullet_image, 90); % rotate 90 degrees counterclockwise
            handle_image = image(obj.position(1) , ...
                obj.position(2), ...
                bullet_image);
        end
        
        % simplified shooting
        function simple_shooting(obj, handle_figure, zombie_obj, rick_obj)
            key = handle_figure.CurrentKey; % get the key pressed from the display_game figure
            
            if obj.flag == 0
                obj.position = [rick_obj.position(1), rick_obj.position(2)];
                step = [-20 0];
                obj.direction = step;
            else
                step = obj.direction;
            end
            
            obj.position = obj.position + step;
            
        end
        
        
        % shooting
        function shooting(obj, handle_figure, zombie_obj, rick_obj)
            key = handle_figure.CurrentKey; % get the key pressed from the display_game figure
            % if strcmp(key,'space')
            bullet_image = imread(obj.image);
            bullet_image = imresize(bullet_image, obj.size);
            if obj.flag == 0
                obj.position = [rick_obj.position(1), rick_obj.position(2)];
                if rick_obj.position(1)<zombie_obj.position(1) && rick_obj.position(2)<zombie_obj.position(2)
                    step = [0 10];
                elseif rick_obj.position(1)>=zombie_obj.position(1) && rick_obj.position(2)<zombie_obj.position(2)
                    step = [0 10];
                elseif rick_obj.position(1)<zombie_obj.position(1) && rick_obj.position(2)>=zombie_obj.position(2)
                    step = [0 -10];
                elseif rick_obj.position(1)>=zombie_obj.position(1) && rick_obj.position(2)>=zombie_obj.position(2)
                    step = [0 -10];
                end
                obj.direction = step;
            else
                step = obj.direction;
            end
                                    
            obj.position = obj.position + step;
            
        end
        
        % hitting boundary check
        function flag = has_hit_boundary(obj, game_obj)
            % checks if the bullet has hit a bound of the game display; returns 1 if yes, 0 if not
            flag = 0;
            if obj.position(1)<=0
                flag = 1;
            end
            if obj.position(1)>=game_obj.size(1)
                flag = 1;
            end
            if obj.position(2)<=0
                flag = 1;
            end
            if obj.position(2)>=game_obj.size(2)
                flag = 1;
            end
            
            
        end
        
    end
end