<template>
  <div id="app">
    <TerminalEmulator />
    <Links />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import TerminalEmulator from "./components/TerminalEmulator.vue";
import Links from "./components/Links.vue";

@Component({
  components: {
    TerminalEmulator,
    Links,
  },
})
export default class App extends Vue {}
</script>

<style>
@import url("https://fonts.googleapis.com/css?family=Fira+Code&display=swap");

html {
  background-color: rgba(0, 0, 0, 0.884);
}

#app {
  font-family: "Fira Code", Consolas, monospace;
  font-weight: 700;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: rgba(255, 255, 255, 0.822);
}
</style>
