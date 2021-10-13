<template>
   <v-card
      class="mx-auto"
      max-width="344"
   >
      <v-card-text>
         <div class="d-flex justify-space-between">
            <span class="text-h5 text--primary">{{product[1]}}</span>
            <v-chip
               v-if="product[5] === 1"                           
               color="white"
               text-color="red"
            >
               {{product[2]}} qtd
               <v-icon right> mdi-alert</v-icon>
            </v-chip>
            <v-chip
               v-else
               class="ml-2"
               color="white"
               text-color="success"
               small
            >                           
               <v-icon right> mdi-checkbox-multiple-marked-outline</v-icon>
            </v-chip>
         </div>

         <p>Estoque:{{ product[2]}}</p>
         <div class="text--primary">R$: {{product[3]}}</div>
      </v-card-text>
      <v-card-actions>
         <v-btn
         text
         color="orange"
      >
         vender
         </v-btn>
      </v-card-actions>
   </v-card>
</template>