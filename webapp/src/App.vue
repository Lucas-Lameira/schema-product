<template>
  <!-- root component -->
  <v-app>
    <Navbar v-if="loggedIn" />
    <!-- Main content of the page -->
    <v-main class="white darken-1">
      <!-- routers -->
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
import Navbar from "./components/Navbar.vue";
export default {
  name: "App",
  components: {
    Navbar,
  },
  data: () => ({
    loggedIn: false,
  }),
  mounted() {
    this.$store.state.user ? (this.loggedIn = true) : (this.loggedIn = false);
  },
};
</script>
