# Project 3
# Sketch Description
Experience the seasonal variation in the Snowflake Simulation sketch. My inspiration was taken
from the alps visual appearance. Toggle between winter and summer modes to witness the unique
characteristics of each season. In winter mode, snowflakes descend from the sky, influenced by the
subtle movement of the wind. Summer mode showcases a peaceful ambiance and winter mode
creates the visual appearance of a snowy mountain.

# Wind Logic
The program employs various techniques to create a realistic snowflake simulation:
1. Falling Motion: Each snowflake moves in a downward direction, replicating the effect of
gravity.
2. Wind Simulation: To mimic the influence of wind on snowflake movement, the program
introduces a wind factor that adjusts the velocity vector. The wind has two main attributes:
intensity and direction.
3. Wind Intensity: The intensity of the wind determines the speed at which the snowflakes drift
horizontally. It adjusts the wind intensity gradually, adding a dynamic element. Some
snowflakes are moving faster or slower depending on the wind's strength.
4. Wind Direction: The wind direction changes at regular intervals, creating a sense of wind
patterns shifting over time. This feature adds realism to the sketch.

# Design Decisions/ Additional Features
During the development process, various design decisions and additional features were
implemented.
1. 3D Sketch: The sketch was created in Processing’s 3D mode to achieve a more realistic and
immersive representation of the snowflakes and mountain.
2. Snowflake Rotation: Each snowflake rotates around its own axis, adding a subtle spinning
effect. This contributes to the realism of the snowflake's appearance, making it look more
three-dimensional.
3. Pinetrees: To represent the trees on the mountain, 3D shapes were utilised. Triangles were
used to construct individual pyramid-shaped trees, while a box-shaped structure was used for
the tree trunk.
4. Seasonal Modes: The sketch incorporates two extra modes: In summer mode, the scene
adopts a summary atmosphere with playing bird sounds. The winter mode immerses the
viewer in a stronger “snowstorm” featuring thunder sounds.

# Instructions
To operate the Snowflake Simulation, follow these steps:
1. Necessary Libraries: processing.sound (and peasy)
2. Switching Modes: You can switch between summer and winter mode
• Summer: Press the key “S” to enter summer mode and press it again to exit it
• Winter: Press the key “W” to enter winter mode and press it again to exit it

# Future Work
During the project, I tried to make the spheres appear on the mountain surface upon collision. I
implemented collision detection to prevent the snowflakes from sinking into the mountain. I stored
the collided snowflakes in an array and drew spheres at those collision points.
Unfortunately, the spheres are not appearing correctly on the mountain surface despite my efforts. I
checked the code and confirmed that the collision detection and drawing functions are working
properly. However, the spheres seem to be misplaced.
To troubleshoot the issue, I attempted various approaches. One involved comparing the y-
coordinate of the snowflake position with the mountain height and adjusting the snowflake's y-
coordinate accordingly. Additionally, I reviewed the rendering code to ensure the spheres were
being drawn correctly. I suspect there may be an issue with the coordinates due to the rotation
matrix.
At this stage, I'm unsure about the exact cause of the problem. It could be due to errors in
calculating the mountain height, problems with the sphere rendering, or a combination of factors.

# References
To learn how to make use of Processing’s 3D mode and generating my mountain as a triangle strip,
these are the sources I’ve made use of.
https://www.youtube.com/watch?v=IKB1hWWedMk
https://www.youtube.com/watch?v=QpU5XisnH_8
https://processing.org/tutorials/p3d/#3d-shapes
