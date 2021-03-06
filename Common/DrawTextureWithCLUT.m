function DrawTextureWithCLUT(win, src, newclut, srcRect, destRect, rotangle)

% Draws a texture with Color LookupTable you specified (modified version of Screen('DrawTexture')).
% !!! EXPERIMENTAL - BETA QUALITY !!!
%
% function DrawTextureWithCLUT(win_pointer, src_texture, :newclut, :srcRect, :destRect, :rotangle)
% (: is optional)
%
% This function is a modified version of Psychtoolbox (PTB) Screen('DrawTexture') function
% The texture with 0-255 IDs will be painted with a specified Color LookupTable (CLUT).
% This function internally accesses OpenGL Shader API.
%
% Before actual use, run
% >> DrawTextureWithCLUT(win_pointer)
% This will initialize MATLAB OpenGL Pixel Shader settings.
% To clean up OpenGL Pixel Shader settings, run
% >> DrawTextureWithCLUT()
%
%
% Created    : "2011-04-14 01:00:09 ban"
% Last Update: "2013-11-22 18:53:54 ban (ban.hiroshi@gmail.com)"
%
% [input]
% win_pointer  : PTB screen pointer
% src_texture  : source texture pointer, acquired through Screen('MakeTexture') function
%                target texture should contain values 0-255
% newclut      : CLUT you want to use to paint the target texture, [256 x 4(RGBA)] matrix
%                The relation between values in src_texture and newclut is as below
%                 src_texture value 0   ---> newclut(1,:)
%                 src_texture value 1   ---> newclut(2,:)
%                 src_texture value 2   ---> newclut(3,:)
%                 ...
%                 src_texture value n-1 ---> newclut(n,:)
% srcRect      : rectangle that specifies a rectangular subpart of the texture
%                to be drawn (Defaults to full texture)
% destRect     : rectangle that defines the rectangular subpart of the window where the
%                texture should be drawn. this default is to centered on the screen
% rotangle     : specifies a rotation angle in degree for rotated drawing of the texture
%                (defaults to 0 deg. = upright)
%
%
% [output]
% no output
% src_texture will be drawn to PTB screen (but the screen itself is not flipped)


% [reference]
%
% moglClutBlit(win, src [, newclut]) -- Blit an image into window, apply CLUT.
%
% moglClutBlit copies a texture image 'src' (either made via
% src = Screen('MakeTexture', ...) or an offscreen window created via
% src = Screen('OpenOffscreenWindow', ...)) to an onscreen window 'win'.
%
% During the copy, it applies a color lookup table (clut) to the texture,
% transforming the color indices in the input texture into RGB color
% pixels according to the color lookup table.
%
% The color lookup table contains 256 rows with 3 columns. The i'th row
% contains the Red, green and blue color values to be used when an input
% pixel with colorindex i-1 is used. Column 1 = Red component, column 2 =
% Green component, column 3 = blue component.
%
% The clut will be initialized to a gray-level ramp, i.e. index 1 =
% (0,0,0), index i+1 = (i, i, i), index 256 = (255, 255, 255).
%
% Arguments:
%
% 'src' texture handle or offscreen window handle of the image to copy.
% 'win' window handle of the target window.
% 'newclut' The new 256 rows by 3 columns clut. If you don't provide any
% clut, the clut from a previous call will be used. Initially it is a
% graylevel ramp.
%
% Usage:
% 1. Add the command "InitializeMatlabOpenGL" at the top of your script,
% before the first call to Screen('OpenWindow', ...). If you don't use any
% 3D graphics, InitializeMatlabOpenGL([], 0, 1); will be the fastest.
%
% 2. Create your color index image either as a texture, e.g., via
% src=Screen('MakeTexture', win, myimage), or create it as Offscreen window
% src=Screen('OpenOffscreenWindow', win) and draw your index colored
% stimulus into it.
%
% 3. Whenever you want to change the clut and draw the image with updated
% clut, call moglClutBlit(win, src, newclut); with newclut being the new
% color lookup table.
%
% 4. Call the Screen('Flip', ...) command to show the new image, drawn with
% the new clut.
%
% 5. At the end of your script and before you Screen('Close', win) or
% Screen('CloseAll'), call moglClutBlit() without parameters, so it can
% clean up after itself.
%
% See GLSLClutAnimDemo for an example.
%
% Note: This function requires you to use fairly recent graphics hardware
% with support for OpenGL Pixelshaders and the OpenGL shading language
% (GLSL). It won't work on old hardware. Use of cluts for 8 bit clut
% animation is deprecated. Today, most stimuli can be generated in much more
% flexible and elegant ways using PTB-3's new drawing features and OpenGL
% capabilities.

% History:
% 6.11.2006 Written (MK).
% 2.03.2008 Performance improvements (MK).

% Our handle to OpenGL:
global GL;

persistent initialized;
persistent remapshader;
persistent luttex;
persistent clut;

% First time invocation?
if isempty(initialized) || nargin==1
    % Make sure GLSL and pixelshaders are supported on first call:
    AssertGLSL;
    extensions = glGetString(GL.EXTENSIONS);
    if isempty(findstr(extensions, 'GL_ARB_fragment_shader'))
        % No fragment shaders: This is a no go!
        error('DrawTextureWithCLUT: Sorry, this function does not work on your graphics hardware due to lack of sufficient support for fragment shaders.');
    end

    % Load our fragment shader for clut blit operations:
    remapshader = LoadGLSLProgramFromFiles('ClutBlitShader.frag.txt');
    glUseProgram(remapshader);
    % Assign proper texture units for input image and clut:
    shader_image = glGetUniformLocation(remapshader, 'Image');
    shader_clut  = glGetUniformLocation(remapshader, 'clut');

    glUniform1i(shader_image, 0);
    glUniform1i(shader_clut, 1);
    glUseProgram(0);

    % Build a gray-ramp as texture:
    clut = uint8(zeros(1, 256*4));
    for i=0:255
        clut(1 + i*4 + 0)= i;
        clut(1 + i*4 + 1)= i;
        clut(1 + i*4 + 2)= i;
        clut(1 + i*4 + 3)= 1;
    end

    % Select the 2nd texture unit (unit 1) for setup:
    glActiveTexture(GL.TEXTURE1);
    luttex = glGenTextures(1);
    glBindTexture(GL.TEXTURE_RECTANGLE_EXT, luttex);
    glTexImage2D(GL.TEXTURE_RECTANGLE_EXT, 0, GL.RGBA, 256, 1, 0, GL.RGBA, GL.UNSIGNED_BYTE, clut);

    % Make sure we use nearest neighbour sampling:
    glTexParameteri(GL.TEXTURE_RECTANGLE_EXT, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
    glTexParameteri(GL.TEXTURE_RECTANGLE_EXT, GL.TEXTURE_MAG_FILTER, GL.NEAREST);

    % And that we clamp to edge:
    glTexParameteri(GL.TEXTURE_RECTANGLE_EXT, GL.TEXTURE_WRAP_S, GL.CLAMP);
    glTexParameteri(GL.TEXTURE_RECTANGLE_EXT, GL.TEXTURE_WRAP_T, GL.CLAMP);

    % Default CLUT setup done: Switch back to texture unit 0:
    glActiveTexture(GL.TEXTURE0);

    % We are initialized:
    initialized = 1;

    % just initializing
    if nargin==1, return; end

end % of initialization.

% No arguments provided?
if nargin < 1
    % This is a signal that we should shut-down and release all internal
    % ressources:
    glActiveTexture(GL.TEXTURE1);
    glBindTexture(GL.TEXTURE_RECTANGLE_EXT, 0);
    glDisable(GL.TEXTURE_RECTANGLE_EXT);
    glDeleteTextures(1, luttex);
    luttex=-1;
    glActiveTexture(GL.TEXTURE0);
    glUseProgram(0);
    % Disabled for now: glDeleteProgram(remapshader);
    remapshader=-1;
    clear initialized;
    clear clut;
    return;
end

if nargin < 1 || isempty(win)
    error('DrawTextureWithCLUT: Handle to target onscreen window ''win'' missing!');
end

if nargin < 2 || isempty(src)
  disp('Initializing MATLAB OpenGL pixel shader settings...');
  %error('DrawTextureWithCLUT: Handle to input image ''src'' (either texture or offscreen window) missing!');
end

% Select the 2nd texture unit (unit 1) for setup:
glActiveTexture(GL.TEXTURE1);
% Bind our clut texture to it:
glBindTexture(GL.TEXTURE_RECTANGLE_EXT, luttex);

% New clut provided?
if nargin > 2 && ~isempty(newclut)
    % Yes. Update our clut texture with it.

    % Size check:
    if size(newclut,1)~=256 || size(newclut, 2)~=4
        % Invalid or missing clut:
        error('newclut of wrong size (must be 256 rows by 4 columns) provided!');
    end

    % Range check:
    if ~isempty(find(newclut < 0, 1)) || ~isempty(find(newclut > 255, 1))
        % Clut values out of range:
        error('At least one value in newclut is not in required range 0 to 255!');
    end

    % Cast to integer and update our 'clut' array with new clut:
    clut(1:4:end-3)= uint8(newclut(:, 1) + 0.5);
    clut(2:4:end-2)= uint8(newclut(:, 2) + 0.5);
    clut(3:4:end-1)= uint8(newclut(:, 3) + 0.5);
    clut(4:4:end-0)= newclut(:, 4);

    % Upload new clut:
    glTexSubImage2D(GL.TEXTURE_RECTANGLE_EXT, 0, 0, 0, 256, 1, GL.RGBA, GL.UNSIGNED_BYTE, clut);
end

if nargin < 4 || isempty(srcRect)
  srcRect=[];
end

if nargin < 5 || isempty(destRect)
  destRect=[];
end

if nargin < 6 || isempty(rotangle)
  rotangle=0;
end

% Switch back to texunit 0 - the primary one:
glActiveTexture(GL.TEXTURE0);

% Clut and shader are initialized. Activate shader:
%glUseProgram(remapshader);

% Perform blit with nearest neighbour filter:
%Screen('DrawTexture', win, src, [], [], 0, 0);

% New style: Needs Screen-MEX update to fix a bug in Screen before it can be used!
Screen('DrawTexture', win, src, srcRect, destRect, rotangle, 0, [], [], remapshader);

% Disable shader:
%glUseProgram(0);

% We're done.
end
