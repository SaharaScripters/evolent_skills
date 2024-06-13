<script lang="ts">
  import { skills } from "../store/skills";
  import { title } from "../store/stores";
  import Skill from "./Skill.svelte";
  import { slide } from "svelte/transition";

  let myTitle = 'My Skills';


  title.subscribe((newTitle: string) => {
    myTitle = newTitle;
  });
</script>

<div
  class="skills-container"
  in:slide={{ duration: 200 }}
  out:slide={{ duration: 200 }}
>
  <div class="skills-header">
    <p>{myTitle}</p>
  </div>

  <div class="skills-list">
    {#if $skills.length === 0}
      <p>No skills to show</p>
    {/if}
    {#each $skills as skill (skill.label)}
      <Skill {skill} />
    {/each}
  </div>
</div>

<style scoped>
  @import "$styles/skills.css";
</style>
