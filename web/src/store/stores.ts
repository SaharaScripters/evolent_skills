import { writable } from "svelte/store";

export const visibility = writable(false);

export const title = writable("Hello, Svelte!");
