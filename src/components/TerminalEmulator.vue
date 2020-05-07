<template>
  <div class="terminal-container" @click="inputFocus">
    <div class="terminal-bar" ref="bar">
      <div class="terminal-bar-button terminal-bar-button-minimize"></div>
      <div class="terminal-bar-button terminal-bar-button-expand"></div>
      <div class="terminal-bar-button terminal-bar-button-close"></div>
    </div>
    <div class="terminal-history" ref="box">
      <span
        v-for="(entry, index) in history"
        :key="index"
        class="terminal-history-input"
      >
        {{ entry }}
      </span>
      <div class="terminal-input">
        <span class="prepend">{{ prepend }}</span>
        <input
          aria-label="Command input"
          type="text"
          v-model="input"
          @keyup.enter.exact="onEnter"
          @keydown.ctrl.76.prevent="cleanTerminal"
          @keyup.ctrl.67.prevent="cancelCommand"
          ref="input"
        />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

@Component
export default class TerminalEmulator extends Vue {
  public input: string = "";

  public history: string[] = [];

  public prepend: string = "λ";

  public onEnter(): void {
    if (this.input) {
      this.history.push(this.prepend + " " + this.input);

      switch (this.input) {
        case "help": {
          this.history.push("The following commands are available: ");
          this.history.push("jobs -- shows the companies I've worked for and the dates (this stuff is definitely outdated by the time you're seeing this)");
          this.history.push("projects -- shows my projects (probably very outdated as well)");
          this.history.push("clear -- clears the terminal history");
          break;
        }
        case "ls": {
          this.history.push("set 22 14:41 projects");
          break;
        }
        case "jobs": {
          this.history.push("WiZED - Feb. 2019 to Dec. 2019");
          this.history.push("> Developed core features of the system in Angular 8 with Google Cloud Platform (Cloud Functions in Node.js, Cloud Vision, Firebase Firestore and Realtime Database, etc).");
          this.history.push("> Led and helped a team of 3 interns on learning Angular and applying it.");
          break;
        }
        case "projects": {
          this.history.push("Magiscript");
          this.history.push("> Tool to automate some mechanical processes in Brazil's justice system.");
          this.history.push("> Presented during Hackathon Inova TRT/SC and awarded a honorable mention, also chosen by the mentors.");
          break;
        }
        case "clear": {
          this.history = [];
          break;
        }
        default: {
          this.history.push(`Command not found: ${this.input}`);
        }
      }
      this.input = "";
    }
    this.scrollToEnd();
  }

  public cleanTerminal(): void {
    this.history = [];
  }

  public cancelCommand(): void {
    this.history.push(this.prepend + " " + this.input);
    this.input = "";
  }

  public inputFocus(): void {
    const field = this.$refs.input as HTMLInputElement;
    field.focus();
  }

  public scrollToEnd(): void {
    const container = this.$refs.box as HTMLDivElement;
    const bar = this.$refs.bar as HTMLDivElement;
    this.$nextTick(() => {
      container.scrollTop = container.scrollHeight + bar.scrollHeight;
    });
  }

  public mounted(): void {
    this.inputFocus();
    this.history.push("Type help for the available commands.");
  }
}
</script>

<style lang="scss" scoped>
input[type="text"] {
  all: unset;
  width: 100%;
  border-radius: 0px;
  border: 0;
  background-color: transparent;
  color: rgba(255, 255, 255, 0.822);
  font-size: 15px;
}

.prepend {
  font-size: 15px;
  margin-right: 9px;
}

.terminal {
  &-container {
    display: flex;
    flex-direction: column;
    max-width: 1200px;
    height: calc(100vh - 90px);
    font-weight: 400;
    border-radius: 10px;
    margin-right: 15px;
    margin-left: 15px;
    margin-right: auto;
    margin-left: auto;
    background-color: #242424;
  }

  &-bar {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: flex-end;
    width: 100%;
    background-color: #3f3e3f;
    border-top-right-radius: 10px;
    border-top-left-radius: 10px;
    height: 25px;
    min-height: 25px;

    &-button {
      border-radius: 50%;
      width: 15px;
      height: 15px;
      margin-right: 8px;

      &-minimize {
        background-color: #f7c235;
      }
  
      &-expand {
        background-color: #38e647;
      }
    
      &-close {
        background-color: #f04f55;
      }
    }
  }

  &-input {
    display: flex;
    flex-direction: row;
  }

  &-history {
    display: flex;
    flex-direction: column;
    overflow-y: auto;
    padding: 10px;
    font-size: 15px;

    &-input {
      width: 100%;
      word-wrap: break-word;
    }

    &::-webkit-scrollbar {
      width: 5px;
    }

    &::-webkit-scrollbar-track {
      -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
    }

    &::-webkit-scrollbar-thumb {
      background-color: rgb(46, 45, 45);
      outline: #242424;
    }
  }
}
</style>
