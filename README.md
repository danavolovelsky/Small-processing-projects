## Project 1
# Inspiration from Artist and Artwork
In this project, I draw inspiration from the renowned artist Mark Rothko. Mark Rothko is widely
recognized for his contributions to abstract expressionism, and his paintings are known for their
profound emotional impact. (https://www.wikiart.org/en/mark-rothko)
Rothko's unique style consists of featuring small and large rectangular shapes with either
contrasting or complementary colors that invite to contemplate the interplay of color and form.

# Sketch Description
Inspired by Rothkos artistic style, this sketch aims to capture the essence of color and shape
relationships. The focal point of the composition is a series of stacked rectangles, each with its own
distinct height and color scheme.

# Design Decisions
1. Embracing Randomness: Randomness plays a significant role in this sketch, mirroring the
unpredictable nature of artistic creation. The generateRectangles() function incorporates
random elements, such as the number of rectangles, their heights, and even the background
color. This randomness ensures that each execution of the sketch creates a unique visual
experience, making it an ever-evolving artwork.
2. Color as Expression: Inspired by Rothko's colourful nature, the sketch introduces three color
themes (red, green, blue). Each of the rectangles and the background get assigned a random
color in the corresponding hue.
3. Interactive Engagement: Interactivity is an integral part of this sketch, empowering to
actively engage with the artwork. With each press of the mouse a different piece gets
displayed on the canvas. They are all in a similar form but still unique, meaning you will not
get the same exact design again.
4. Organic Rectangles: The rectangles are composed of multiple lines of varying lengths,
mirroring the raw and rough edges found in Rothko's paintings. This helps to capture the
essence of Rothko’s artistic expression.

## Project 2
# Sketch Description
The music player instrument is designed to provide a visually appealing and interactive experience
for users. It resembles a record player, featuring a rotating disc and album covers on the side. Users
can control volume, frequency, and timbre to customise the music. The goal is to create a nostalgic
atmosphere by blending traditional record player elements with modern digital music, using visuals
like album covers and a stylus to connect with physical media while enjoying the convenience of
digital music.

# Design Decisions
Throughout the development process, several adjustments and enhancements were made to improve
the record players functionality and user experience.
1. Record Rotation Speed: The rotation speed of the record is adjusted based on the frequency
value set by the user. This change allows for a more synchronised visual representation of the
music's tempo.
2. AI-Generated Album Covers: I used the artificial intelligence model "DALL·E 2" to
generate album covers that match the royalty-free music selection. This ensures that each
album cover is unique, fitting and visually appealing.
3. Vintage Scratch Effect: I incorporated a scratch effect that mimics the experience of playing
a vintage record. By adjusting the intensity of this effect using the timbre slider, a lowpass
filter is applied to produce a more authentic and nostalgic sound.

# Instructions
To operate the record player, follow these steps:
1. Necessary Libraries: controlP5 and processing.sound
2. Interact with Sliders: Use the sliders labeled "Volume," "Frequency," and "Timbre" to
control different aspects of the music.
• Volume: Adjust the volume of the currently playing song
• Frequency: Change the playback frequency of the song, altering its speed and pitch
• Timbre: Control the intensity of the lowpass filter and the scratch effect
3. Choose a Song: Press keys 1, 2 or 3 to select and play one of the available songs. Pressing the
spacebar will pause or resume the currently playing song.
The songs used are royalty-free and sourced from Bensound.com. Users can enhance and
personalise their experience by adding their own preferred songs.

## Project 3
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
