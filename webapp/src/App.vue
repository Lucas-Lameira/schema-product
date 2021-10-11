<template>
  <!-- root component -->
  <v-app>
    <Navbar />
    <!-- Main content of the page -->
    <v-main class="grey darken-1">
      <!-- routers -->
      <router-view/> 
    </v-main>
  </v-app>
</template>

<script>
  import Navbar from './components/Navbar.vue';
  export default {
    name: 'App',
    components: {
      Navbar
    },
    data: () => ({
      //
    }),
  };
</script>
