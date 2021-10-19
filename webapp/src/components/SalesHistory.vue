<template>
  <div>
    <h1>Sales</h1>

    <!-- <template>
      <v-expansion-panels>
        <v-expansion-panel v-for="(item, i) in 5" :key="i">
          <v-expansion-panel-header>
            {{ new Date("Mon, 07 Jun 2021 00:00:00 GMT") }}
          </v-expansion-panel-header>
          <v-expansion-panel-content>
            
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </template> -->

    <v-card v-for="(sale, index) in sales" :key="index" class="my-2">
      <v-card-text>
        <p>Vendedor: {{ sale[2] }}</p>
        <p>Data: {{ sale[4] }}</p>

        <span class="mr-8 mb-8">cod: {{ sale[5] }}</span>
        <span>Produto: {{ sale[6] }}</span>
        <p>Quantidade: {{ sale[7] }}</p>
        <span>Preço R$: {{ sale[8] }}</span>
      </v-card-text>
    </v-card>
  </div>
</template>


<script>
import api from "../services/api";
export default {
  name: "SalesHistory",
  data() {
    return {
      sales: [],
    };
  },
  async created() {
    try {
      const result = await api.get("/sales/history");
      this.sales = result.data;
    } catch (error) {
      console.log(error);
    }
  },
};
</script>