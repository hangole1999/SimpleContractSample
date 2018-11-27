#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>

using namespace eosio;

class simplectr : public eosio::contract {
  public:
      using contract::contract;

      /// @abi table _calltab i64
      struct calltab
      {
         int64_t id;
         int64_t act;
         int64_t data;
         uint64_t primary_key() const {return id;}
         EOSLIB_SERIALIZE(ttab, (id) (act) (data))
      };
      
      typedef multi_index<N(calltab),calltab> _calltab;

      int64_t data;

      /// @abi action
      void setdata( int64_t data ) {
         _calltab calltabs(_self,_self);

         calltabs.emplace(_self,[&](auto& calltab) {
            calltab.id = calltabs.available_primary_key();
            calltab.act = 1;
            calltab.data = data;
         });
      }

      void cbonsetdata( int64_t data ) {
         this->data = data;
      }
};

EOSIO_ABI( simplectr, (setdata) (cbonsetdata) )
