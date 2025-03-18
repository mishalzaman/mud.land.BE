# mud.land.BE

Overview

This Rails API handles authentication and data management for a procedural terrain generator. It provides endpoints for user authentication, terrain data storage, and retrieval. This application is a strictly API-only backend with no frontend components.

## Backend Features

- User authentication
- CRUD operations for terrain data
- Secure API endpoints with authentication
- Data handling for procedural terrain generation

## Frontend Features

- Using WebGPU compute shaders to generate heightmap
- Generate procedural terrain by stacking and blending different noise gradients (simplex, voronoi etc), masking and fall-offs
- Simulate erosion over a period of time
- Allow user to manually edit the terrain by pouring water and creating erosion through rivers and lakes. Or lift the land to block of water.
- Set colourisations through materials
- Export the terrain as heightmap image or mesh

### Current Iteration of the Frontend

![version 0.10.108](app.png "Procedural Terrain")
| The above screenshot is rendering at 4k heightmap texture. It runs at 60fps (capped) on a GTX 970 4gb ram. I plan to increase to 8k through tiled textures. Although that's a future plan as 4k is sufficient at the moment. Also note, I am not a designer!