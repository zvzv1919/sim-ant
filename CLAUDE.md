# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SimAnt is a Godot 4.3 game where clicking spawns colored dots (ants) that move to the right. Built with GDScript.

## Running the Game

```bash
# Command line
godot --path .

# macOS app
/Applications/Godot.app/Contents/MacOS/Godot --path .
```

Or open in Godot editor and press F5.

## Architecture

- **Main scene** (`main.tscn` / `main.gd`): Entry point. Instances World and HUD, wires HUD signals to World properties.
- **World** (`world/world.tscn` / `world/world.gd`): Game environment. Owns ant scene preloads, click-to-spawn input, spawn timer, and ant instantiation.
- **HUD** (`hud/hud.tscn` / `hud/hud.gd`): Side panel UI. Owns ant-type buttons and spawn interval slider. Emits `ant_type_selected` and `spawn_interval_changed` signals.
- **Sprites** (`sprites/`): PNG sprite images for each ant type, also used as button icons in the HUD.
- **Ant base class** (`ants/ant.gd`): `class_name Ant`, extends `Node2D`. Provides `speed` property and `_process` movement (rightward, auto-frees off-screen).
- **Ant types** (`ants/`): Each ant type has a `.gd` + `.tscn` pair. All extend `Ant`, override `_ready()` to set speed. Each `.tscn` includes a `Sprite2D` child with the corresponding sprite texture:
  - `fire_ant` — red circle sprite, speed 200
  - `leaf_cutter` — green circle sprite, speed 150
  - `army_ant` — yellow triangle sprite, speed 250
  - `bullet_ant` — blue square sprite, moves leftward with increasing speed (overrides `_process`)

## Adding a New Ant Type

1. Create a sprite PNG in `sprites/<name>.png`
2. Create `ants/<name>.gd` extending `Ant`, set speed in `_ready()`
3. Create `ants/<name>.tscn` with a Node2D root using that script and a `Sprite2D` child with the sprite texture
4. Add the scene to `ant_scenes` dict in `world/world.gd`
5. Add a button with sprite icon in `hud/hud.tscn` and wire it up in `hud/hud.gd`

## Rules

- When making changes that affect project structure, architecture, or conventions, update this CLAUDE.md file to stay in sync.
- Last synced at commit: `0a118bf`

## Key Conventions

- Viewport: 1152×648
- Ants render via `Sprite2D` nodes with PNG sprites from `sprites/`; UI buttons show the same sprites as icons
- Ant scenes are preloaded in `world/world.gd` via a dictionary mapping type name to scene
