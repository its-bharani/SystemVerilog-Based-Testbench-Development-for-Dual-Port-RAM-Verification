class ram_gen;

reg_trans trans_h;
reg_trans data2send;
int no_of_trans=100;
  mailbox #(reg_trans)gen2wrdr;
  mailbox #(reg_trans)gen2rddr;
  function new(mailbox #(reg_trans)gen2wrdr,
               mailbox #(reg_trans)gen2rddr);
        this.gen2wrdr=gen2wrdr;
endfunction


virtual task start();
repeat(no_of_trans)begin

        trans_h=new;
        assert(trans_h.randomize());
        data2send=new trans_h;//shallow copy
        gen2wrdr.put(data2send);
        gen2rddr.put(data2send);//put data into mailbox
end
endtask
endclass
~
