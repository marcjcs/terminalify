<template>
  <div class="links">
    <a
      v-for="(link, index) in links"
      :key="index"
      :href="link.route"
      :aria-label="link.label"
      target="_blank"
    >
      <font-awesome-icon :icon="link.icon" class="link-item" />
    </a>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

export interface ExternalLink {
  icon: string[];
  route: string;
  label: string;
}

@Component
export default class Links extends Vue {
  private links: ExternalLink[] = [
    {
      icon: ["fab", "github"],
      route: "https://github.com/marcjcs",
      label: 'Github',
    },
    {
      icon: ["fab", "linkedin"],
      route: "https://www.linkedin.com/in/marcjcs/",
      label: 'LinkedIn',
    },
    {
      icon: ["fas", "envelope"],
      route: "mailto:m.juniorcsebastiao@gmail.com",
      label: 'Email',
    },
  ];
}
</script>

<style scoped>
.links {
  display: flex;
  justify-content: space-evenly;
  width: 100%;
  margin: 20px 0px 0px 0px;
  max-width: 1200px;
  margin-right: auto;
  margin-left: auto;
}

.link-item {
  color: white;
  font-size: 50px;
}
</style>
