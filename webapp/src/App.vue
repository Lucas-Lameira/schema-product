<template>
  <!-- root component -->
  <v-app>
    <Navbar v-if="isAuth" />
    <!-- Main title -->
    <h1 class="text-center mt-4">
      <span class="orange--text text">App</span>Product
      <span><v-icon>mdi-user</v-icon></span>
    </h1>
    <!-- Main content of the page -->

    <v-main class="white darken-1">
      <!-- routers -->
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import Navbar from "./components/Navbar.vue";
export default {
  name: "App",
  components: {
    Navbar,
  },
  data: () => ({
    loggedIn: false,
  }),
  methods: mapActions(["fetchCategories"]),
  computed: mapGetters(["isAuth"]),
  created() {
    this.fetchCategories();
  },
};
</script>
