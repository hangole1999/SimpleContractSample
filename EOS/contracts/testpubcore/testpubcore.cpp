#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>

using namespace eosio;
using std::string;

class testpubcore : public eosio::contract {
  public:
      using contract::contract;

      /// @abi table _ttab i64
      struct ttab
      {
         int64_t id;
         int64_t data;
         int64_t call;
         uint64_t primary_key() const {return id;}
         EOSLIB_SERIALIZE(ttab, (id) (data) (call))
      };
      
      typedef multi_index<N(ttab),ttab> _ttab;

      /// @abi action 
      void ontested( int64_t data ) {

         _ttab ttabs(_self,_self);

         ttabs.emplace(_self,[&](auto& ttab) {
            ttab.id = ttabs.available_primary_key();
            ttab.data = data;
            ttab.call = 2;
         });

         print ("ontested()");
      }
};

EOSIO_ABI( testpubcore, (ontested) )
