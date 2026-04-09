---
name: frontend-design
description: Use when building web components, pages, applications, landing pages, dashboards, or any web UI. Use when the user asks to create, style, or beautify frontend interfaces. Ensures distinctive, production-grade design that avoids generic AI aesthetics.
---

# Frontend Design

Create distinctive, production-grade frontend interfaces with high design quality. This skill ensures every web UI avoids generic "AI slop" aesthetics and delivers genuinely memorable design.

## Design Thinking

Before coding, understand the context and commit to a BOLD aesthetic direction:

- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Pick an extreme: brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian, etc.
- **Constraints**: Technical requirements (framework, performance, accessibility).
- **Differentiation**: What makes this UNFORGETTABLE? What's the one thing someone will remember?

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work — the key is intentionality, not intensity.

Then implement working code (HTML/CSS/JS, React, Vue, etc.) that is:
- Production-grade and functional
- Visually striking and memorable
- Cohesive with a clear aesthetic point-of-view
- Meticulously refined in every detail

## Aesthetics Guidelines

### Typography
Choose fonts that are **beautiful, unique, and interesting**. Avoid generic fonts like Arial and Inter. Opt for distinctive choices from Google Fonts that elevate the aesthetics. Pair a distinctive display font with a refined body font.

### Color & Theme
Commit to a cohesive aesthetic. Use CSS variables for consistency. Dominant colors with sharp accents outperform timid, evenly-distributed palettes.

### Motion
Use animations for effects and micro-interactions. Prioritize CSS-only solutions for HTML. Focus on high-impact moments: one well-orchestrated page load with staggered reveals (animation-delay) creates more delight than scattered micro-interactions. Use scroll-triggering and hover states that surprise.

### Spatial Composition
Unexpected layouts. Asymmetry. Overlap. Diagonal flow. Grid-breaking elements. Generous negative space OR controlled density.

### Backgrounds & Visual Details
Create atmosphere and depth rather than defaulting to solid colors. Apply creative forms like:
- Gradient meshes, noise textures
- Geometric patterns, layered transparencies
- Dramatic shadows, decorative borders
- Custom cursors, grain overlays

## NEVER Use

- Generic fonts: Inter, Roboto, Arial, system fonts
- Cliché colors: purple gradients on white backgrounds
- Predictable layouts and component patterns
- Cookie-cutter design that lacks context-specific character

Interpret creatively and make unexpected choices that feel genuinely designed for the context. No two designs should look the same. Vary between light and dark themes, different fonts, different aesthetics. NEVER converge on common choices across generations.

## Asset Generation

When the design needs images, icons, or visual assets, use the `generate_image` tool to create custom assets rather than using placeholders. This ensures every interface feels complete and polished.

## Implementation Complexity

Match implementation complexity to the aesthetic vision:
- **Maximalist designs**: Elaborate code with extensive animations and effects
- **Minimalist/refined designs**: Restraint, precision, careful attention to spacing, typography, and subtle details

Elegance comes from executing the vision well.

## Quick Reference

| Element | Approach |
|---------|----------|
| Fonts | Google Fonts — distinctive, characterful |
| Colors | CSS variables, dominant + accent palette |
| Animation | CSS-only preferred, staggered reveals |
| Layout | Asymmetric, grid-breaking, unexpected |
| Backgrounds | Gradients, textures, depth layers |
| Assets | `generate_image` for custom visuals |
| Testing | `browser_subagent` for visual verification |
