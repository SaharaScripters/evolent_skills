export type Skill = {
  label: string,
  description: string,
  level: number,
  xp: number,
  levelData: {
    minXp: number,
    maxXp: number,
  },
  icon: string,
  color: string,
}