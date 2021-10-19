<template>
  <div>
    <h1>Purchases</h1>

    <!-- <template>            
      <v-expansion-panels>
        <v-expansion-panel>
          <v-expansion-panel-header>
            {{ new Date(purchase[0]) }}
          </v-expansion-panel-header>

          <v-expansion-panel-content>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </template> -->

    <v-card v-for="(purchase, index) in purchases" :key="index" class="my-2">
      <v-card-text>
        <p>Data: {{ purchase[0] }}</p>
        <p>Produto: {{ purchase[4] }}</p>
        <p>Quantidade: {{ purchase[2] }}</p>
        <span>Preço R$: {{ purchase[1] }}</span>
        <p v-if="purchase[3] === 1" class="green--text">inserido</p>
        <p v-else class="red--text">inserido</p>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import api from "../services/api";
export default {
  name: "PurchasesHistory",
  data() {
    return {
      purchases: [],
      /* purchases: [
        ["Thu, 06 May 2021 00:00:00 GMT", "2.80", 12, 1, "macarrao legal 250g"],
        ["Fri, 07 May 2021 00:00:00 GMT", "7.40", 2, 1, "cortador de unha"],
      ], */
    };
  },
  async created() {
    try {
      const result = await api.get("/purchases/history");
      this.purchases = result.data;
    } catch (error) {
      console.log(error);
    }
  },
};
</script>