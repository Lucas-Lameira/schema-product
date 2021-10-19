<template>
  <nav>
    <v-toolbar>
      <!-- logo -->
      <v-toolbar-title>
        <span class="orange--text font-weight-bold">APP</span>
        <span class="font-weight-medium">roduct</span>
      </v-toolbar-title>

      <v-spacer></v-spacer>

      <!-- menu tabs for navigation -->
      <div>
        <v-tabs>
          <v-tabs-slider color="orange"></v-tabs-slider>
          <v-tab
            v-for="route in routes"
            :key="route.name"
            :to="route.route"
            exact
            class="black--text font-weight-medium"
          >
            {{ route.name }}
          </v-tab>
        </v-tabs>
      </div>

      <v-spacer></v-spacer>

      <Cart />

      <!-- dropdown menu -->
      <v-menu offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-btn class="orange white--text" v-bind="attrs" v-on="on">
            <span>{{ getUser[1] }}</span>
            <v-icon right>mdi-menu-down-outline</v-icon>
          </v-btn>
        </template>
        <v-list>
          <v-list-item>
            <v-list-item-title @click="signout"> Sign out </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-toolbar>
  </nav>
</template>

<script>
import { mapGetters } from "vuex";
import Cart from "./Cart.vue";

export default {
  name: "Navbar",
  components: {
    Cart,
  },
  data() {
    return {
      routes: [
        { route: "/home", name: "Home" },
        { route: "/products", name: "Product" },
        { route: "/sales", name: "Sale" },
        { route: "/purchases", name: "Purchase" },
        { route: "/history", name: "History" },
      ],
      menuItens: ["signout"],
    };
  },
  methods: {
    signout() {
      console.log("sair");
      this.$store.dispatch("logout");
      this.$router.replace({ name: "Login" });
      // mover para a página de login
      /* this.$router.push("/login"); */
    },
  },
  computed: mapGetters(["getUser"]),
};
</script>