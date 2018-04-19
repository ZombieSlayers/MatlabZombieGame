classdef Rick < handle
    properties 
        image;
        position;
        direction;
        size;

    end
    methods
        % constructor 
        function obj = Rick(i, p, d, s ) % , l, b)
            obj.image = i;
            obj.position = p;
            obj.direction = d;
            obj.size = s;
        end

        % put it in the game
        function handle_image = rick_on_game_board(obj)
        % RICK_ON_THE_GAME_BOARD plots the image of Rick into the game board
            rick_image = imread(obj.image);
            rick_image = imresize(rick_image, obj.size);
            handle_image = image(obj.position(1) , ...
                obj.position(2), ...
                rick_image);
        end

        % movements

        function move(obj , handle_figure)
            % MOVE makes Rick move around the screen. It picks the CurrentKey in the display_game figure, and moves the image of Rick in the corresponding direction. The property obj.direction is modified by this function.
            key = handle_figure.CurrentKey; % get the key pressed from the display_game figure
            % change direction depending on the arrow key pressed (notice that vertical movement has origin on NW corner)
            if strcmp(key,'uparrow')
                obj.direction = [0 -10];
            elseif strcmp(key,'downarrow')
                obj.direction = [0 10];
            elseif strcmp(key,'rightarrow')
                obj.direction = [10 0];
            elseif strcmp(key,'leftarrow')
                obj.direction = [-10 0];
            end
            
            obj.position = obj.position + obj.direction;
            
            obj.has_hit_boundary; % make sure it is in the boundary of the screen game

        end       


        % hitting boundary check
        function has_hit_boundary(obj)
        % HAS_HIT_BOUNDARY deals with Rick hitting boundary of the figure. 
            if obj.position(1)<0
                obj.position(1) = 0;
            end
            if obj.position(1)>800
                obj.position(1) = 800;
            end
            if obj.position(2)<0
                obj.position(2) = 0;
            end
            if obj.position(2)>600
                obj.position(2) = 600;
            end
            
        end                   

    end
end