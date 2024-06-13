<script lang="ts">
  import VisibilityProvider from './providers/VisibilityProvider.svelte';
  import Skills from './components/Skills.svelte';
  import { debugData } from './utils/debugData';
  import type { Skill } from '$types/skill.ts';

  debugData<{ visible: boolean, title: String, playerSkills: Skill[]}>([
    {
      action: 'showSkills',
      data: {
        visible: true,
        title: 'My Skills',
        playerSkills: [
          {
            label: 'Driving',
            description: 'Are you a good driver?',
            level: 2,
            xp: 176,
            icon: 'fas fa-car',
            color: '#AFC1FF',
            levelData: {
              minXp: 100,
              maxXp: 200
            }
          },
          {
            label: 'Shooting',
            description: 'How do you handle a gun?',
            level: 2,
            xp: 104,
            icon: 'fa-solid fa-gun',
            color: '#ff8888',
            levelData: {
              minXp: 100,
              maxXp: 200
            }
          },
          {
            label: 'Hacking',
            description: 'Can you hack the planet?',
            level: 2,
            xp: 104,
            icon: 'fas fa-laptop',
            color: '#e6e6e6',
            levelData: {
              minXp: 100,
              maxXp: 200
            }
          },
        ],
      }
    }
  ]);
</script>

<main>
  <VisibilityProvider>
    <Skills />
  </VisibilityProvider>
</main>

<style>
  @import '$styles/global.css';
  main {
    height: 100vh;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding-right: 2.0800vw;
  }
</style>
