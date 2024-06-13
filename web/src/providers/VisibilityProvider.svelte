<script lang="ts">
  import { useNuiEvent } from "../utils/useNuiEvent";
  import { fetchNui } from "../utils/fetchNui";
  import { onMount } from "svelte";
  import { visibility, title } from "../store/stores";
  import { skills } from "../store/skills";
  import type { Skill } from "$types/skill";

  let isVisible: boolean;

  visibility.subscribe((visible: boolean) => {
    isVisible = visible;
  });

  useNuiEvent(
    "showSkills",
    (data: { visible: boolean; title: string, playerSkills: Skill[] | undefined }) => {
      if (data.playerSkills) {
        skills.set(data.playerSkills);
      }
      title.set(data.title);
      visibility.set(data.visible);
    },
  );

  onMount(() => {
    const keyHandler = (e: KeyboardEvent) => {
      if (isVisible && ["Escape"].includes(e.code)) {
        fetchNui("hideSkills");
        visibility.set(false);
      }
    };

    window.addEventListener("keydown", keyHandler);

    return () => window.removeEventListener("keydown", keyHandler);
  });
</script>

{#if isVisible}
  <slot />
{/if}
