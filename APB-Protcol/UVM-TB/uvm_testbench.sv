//Code by :: AMLAN PRATEEK ACHARYA :: TESTBENCH
// MEMORY

`include "uvm_macros.svh"
import uvm_pkg::*;

// TRANSACTION //

class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction);
  
  function new(string name="transaction");
    super.new(name);
  endfunction
  
  rand logic pwrite;
  rand logic [31:0] paddr, pwdata;
  logic [31:0] prdata;
  logic pready,pslverr,presetn,pclk,ptransfer;
  
endclass

// REGISTERS //

class ctrl_reg0 extends uvm_reg;
  `uvm_object_utils(ctrl_reg0);
  rand uvm_reg_field data;
  
  function new(string name="ctrl_reg0");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction
  
  function void build();
    data=uvm_reg_field::type_id::create("data");
    data.configure(.parent(this),
                   .size(32),
                   .lsb_pos(0),
                   .access("RW"),
                   .volatile(0),
                   .reset('h0),
                   .has_reset(1),
                   .is_rand(1),
                   .individually_accessible(1));
  endfunction
endclass

class ctrl_reg1 extends uvm_reg;
  `uvm_object_utils(ctrl_reg1);
  rand uvm_reg_field data;
  
  function new(string name="ctrl_reg1");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction
  
  function void build();
    data=uvm_reg_field::type_id::create("data");
    data.configure(.parent(this),
                   .size(32),
                   .lsb_pos(0),
                   .access("RW"),
                   .volatile(0),
                   .reset('h0),
                   .has_reset(1),
                   .is_rand(1),
                   .individually_accessible(1));
  endfunction
endclass


class ctrl_reg2 extends uvm_reg;
  `uvm_object_utils(ctrl_reg2);
  rand uvm_reg_field data;
  
  function new(string name="ctrl_reg2");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction
  
  function void build();
    data=uvm_reg_field::type_id::create("data");
    data.configure(.parent(this),
                   .size(32),
                   .lsb_pos(0),
                   .access("RW"),
                   .volatile(0),
                   .reset('h0),
                   .has_reset(1),
                   .is_rand(1),
                   .individually_accessible(1));
  endfunction
endclass


class ctrl_reg3 extends uvm_reg;
  `uvm_object_utils(ctrl_reg3);
  rand uvm_reg_field data;
  
  function new(string name="ctrl_reg3");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction
  
  function void build();
    data=uvm_reg_field::type_id::create("data");
    data.configure(.parent(this),
                   .size(32),
                   .lsb_pos(0),
                   .access("RW"),
                   .volatile(0),
                   .reset('h0),
                   .has_reset(1),
                   .is_rand(1),
                   .individually_accessible(1));
  endfunction
endclass


class ctrl_reg4 extends uvm_reg;
  `uvm_object_utils(ctrl_reg4);
  rand uvm_reg_field data;
  
  function new(string name="ctrl_reg4");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction
  
  function void build();
    data=uvm_reg_field::type_id::create("data");
    data.configure(.parent(this),
                   .size(32),
                   .lsb_pos(0),
                   .access("RW"),
                   .volatile(0),
                   .reset('h0),
                   .has_reset(1),
                   .is_rand(1),
                   .individually_accessible(1));
  endfunction
endclass

// REGISTER BLOCK //

class reg_block extends uvm_reg_block;
  `uvm_object_utils(reg_block);
  rand ctrl_reg0 reg0;
  rand ctrl_reg1 reg1;
  rand ctrl_reg2 reg2;
  rand ctrl_reg3 reg3;
  rand ctrl_reg4 reg4;
  
  function new(string name="reg_block");
    super.new(name,UVM_NO_COVERAGE);
  endfunction
  
  function void build();
    reg0=ctrl_reg0::type_id::create("reg0");
    reg0.build();
    reg0.configure(this);
    reg1=ctrl_reg1::type_id::create("reg1");
    reg1.build();
    reg1.configure(this);
    reg2=ctrl_reg2::type_id::create("reg2");
    reg2.build();
    reg2.configure(this);
    reg3=ctrl_reg3::type_id::create("reg3");
    reg3.build();
    reg3.configure(this);
    reg4=ctrl_reg4::type_id::create("reg4");
    reg4.build();
    reg4.configure(this);

    default_map=create_map("default_map",0,4,UVM_LITTLE_ENDIAN);
    default_map.add_reg(reg0,'h0,"RW");
    default_map.add_reg(reg1,'h1,"RW");
    default_map.add_reg(reg2,'h2,"RW");
    default_map.add_reg(reg3,'h3,"RW");
    default_map.add_reg(reg4,'h4,"RW");
    default_map.set_auto_predict(0);
    lock_model();
  endfunction
endclass

// WRITE REGISTER SEQUENCE //

class wr_reg_seq extends uvm_sequence;
  `uvm_object_utils(wr_reg_seq);
  reg_block regbl;
  
  function new(string name="wr_reg_seq");
    super.new(name);
  endfunction
  
  task body();
    uvm_status_e status;
    `uvm_info(get_type_name,"WRITE SEQ STARTED",UVM_MEDIUM);
    regbl.reg0.write(status,'h1);
    `uvm_info(get_type_name,$sformatf("Desired : %0h | Mirror : %0h",regbl.reg0.get(),regbl.reg0.get_mirrored_value()),UVM_MEDIUM);
  endtask
  
endclass

// READ REGISTER SEQUENCE //

class rd_reg_seq extends uvm_sequence;
  `uvm_object_utils(rd_reg_seq);
  reg_block regbl;
  
  function new(string name="rd_reg_seq");
    super.new(name);
  endfunction
  
  task body();
    uvm_status_e status;
    bit [7:0] read_data;
    `uvm_info(get_type_name,"READ SEQ STARTED",UVM_MEDIUM);
    regbl.reg0.read(status,read_data);
    `uvm_info(get_type_name,$sformatf("Desired : %0h | Mirror : %0h | Read Data : %0h",regbl.reg0.get(),regbl.reg0.get_mirrored_value(),read_data),UVM_MEDIUM);
  endtask
  
endclass

// ADAPTER //

class adapter extends uvm_reg_adapter;
  `uvm_object_utils(adapter);
  
  function new(string name="adapter");
    super.new(name);
  endfunction
  
  //REG2BUS
  function uvm_sequence_item reg2bus (const ref uvm_reg_bus_op rw);
    transaction tr;
    tr=transaction::type_id::create("tr");
    tr.pwrite=(rw.kind==UVM_WRITE)?'d1:'d0;
    tr.paddr=rw.addr;
    if(tr.pwrite)
      tr.pwdata=rw.data;
    return tr;
  endfunction
  
  //BUS2REG
  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    transaction tr;
    assert($cast(tr,bus_item));
    rw.kind=tr.pwrite?UVM_WRITE:UVM_READ;
    rw.addr=tr.paddr;
    rw.data=(tr.pwrite)?tr.pwdata:tr.prdata;
    rw.status=UVM_IS_OK;
  endfunction
  
endclass

// DRIVER //

class driver extends uvm_driver #(transaction);
  
  `uvm_component_utils(driver);

  function new(string name="driver",uvm_component parent=null);
    super.new(name,parent);
  endfunction
    
  transaction tr;
  virtual apb_system_if apb_if;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"Build Phase",UVM_HIGH)
    if(!uvm_config_db#(virtual apb_system_if)::get(this,"","apb_if",apb_if))
       `uvm_error(get_type_name,"CANNOT GET VIRTUAL INTERFACE")
    tr=transaction::type_id::create("tr");
  endfunction
  
  virtual task main_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(tr);
      `uvm_info(get_type_name(),"Main Phase",UVM_HIGH)
      apb_if.pwrite=tr.pwrite;
      apb_if.ptransfer=1;
      apb_if.paddr=tr.paddr;
      if(tr.pwrite) apb_if.pwdata=tr.pwdata;
      apb_if.presetn=0;
      @(posedge apb_if.pready)
      repeat (2) @(posedge apb_if.pclk)
      apb_if.ptransfer=0;
      if(!tr.pwrite) tr.prdata=apb_if.prdata;
      seq_item_port.item_done();
    end
    
  endtask
  
endclass

// MONITOR //

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor);

  function new(string name="monitor",uvm_component parent=null);
    super.new(name,parent);
  endfunction
    
  transaction tr;
  virtual apb_system_if apb_if;
  uvm_analysis_port #(transaction) send;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"Build Phase",UVM_HIGH)
    if(!uvm_config_db#(virtual apb_system_if)::get(this,"","apb_if",apb_if))
       `uvm_error(get_type_name,"CANNOT GET VIRTUAL INTERFACE");
    tr=transaction::type_id::create("tr");
    send=new("send",this);
  endfunction 
  
  virtual task main_phase(uvm_phase phase);
    
    forever begin
      @(posedge apb_if.pready)
      repeat (2) @(posedge apb_if.pclk)
      `uvm_info(get_type_name(),"Main Phase",UVM_HIGH)
      tr.pwrite=apb_if.pwrite;
      tr.paddr=apb_if.paddr;
      tr.pwdata=apb_if.pwdata;
      tr.prdata=apb_if.prdata;
      tr.pready=apb_if.pready;
      tr.pslverr=apb_if.pslverr;
      `uvm_info(get_type_name(),$sformatf("%0h | %0h | %0h",tr.pwrite,tr.prdata,tr.paddr),UVM_MEDIUM)
      send.write(tr);
    end
    
  endtask
  
endclass

// SCOREBOARD //

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard);
  
  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  uvm_analysis_imp #(transaction,scoreboard) recv_scb;
  logic [31:0] data_check='h0;
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"Build Phase",UVM_HIGH)
    recv_scb=new("recv_scb",this);
  endfunction
  
  virtual function void write (input transaction tr);
  `uvm_info(get_type_name(),"Write Phase",UVM_HIGH)
    if(tr.pwrite) begin
      data_check=tr.pwdata;
      `uvm_info(get_type_name,$sformatf("DATA STORED = %0h",data_check),UVM_MEDIUM);
    end
    else begin
      if(data_check==tr.prdata)
        `uvm_info(get_type_name,$sformatf("PASS :: DATA READ = %0h",data_check),UVM_MEDIUM)
      else 
        `uvm_error(get_type_name,$sformatf("FAIL :: DATA READ [%0h] != DATA STORED [%0h]",tr.prdata,data_check))
    end
  endfunction
  
endclass

// AGENT //

class agent extends uvm_agent;
  `uvm_component_utils(agent);
  
  function new(string name="agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  driver drv;
  monitor mon;
  uvm_sequencer #(transaction) seqr;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv=driver::type_id::create("drv",this);
    mon=monitor::type_id::create("mon",this);
    seqr=uvm_sequencer#(transaction)::type_id::create("seqr",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
endclass

// ENVIRONMENT //

class env extends uvm_env;
  `uvm_component_utils(env);
  
  function new(string name="env", uvm_component parent=null);
    super.new(name,parent);
  endfunction
    
  agent agt;
  scoreboard scb;
  reg_block reg_bl;
  adapter adp;
  uvm_reg_predictor #(transaction) prd;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt=agent::type_id::create("agt",this);
    reg_bl=reg_block::type_id::create("reg_bl");
    reg_bl.build();
    adp=adapter::type_id::create("adp",,get_full_name());
    prd=uvm_reg_predictor#(transaction)::type_id::create("prd",this);
    scb=scoreboard::type_id::create("scb",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    reg_bl.default_map.set_sequencer(.sequencer(agt.seqr),.adapter(adp));
    reg_bl.default_map.set_base_addr(0);
    agt.mon.send.connect(prd.bus_in);
    agt.mon.send.connect(scb.recv_scb);
    prd.map=reg_bl.default_map;
    prd.adapter=adp;
  endfunction
    
endclass

// TEST //

class test extends uvm_test;
  `uvm_component_utils(test);
  
  function new(string name="test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  env e;
  wr_reg_seq wr;
  rd_reg_seq rd;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e=env::type_id::create("e",this);
    wr=wr_reg_seq::type_id::create("wr");
    rd=rd_reg_seq::type_id::create("rd"); 
  endfunction
  
  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    wr.regbl=e.reg_bl;
    rd.regbl=e.reg_bl;
    wr.start(e.agt.seqr);
    #10;
    rd.start(e.agt.seqr);
    //#200;
    phase.drop_objection(this);
  endtask
  
endclass


// TOP //

module top();
  
  apb_system_if apb_if();
  apb_system apb (apb_if.pwrite,apb_if.pclk,apb_if.ptransfer,apb_if.presetn,apb_if.paddr,apb_if.pwdata,apb_if.prdata,apb_if.pready,apb_if.pslverr);

  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    uvm_config_db#(virtual apb_system_if)::set(null,"*","apb_if",apb_if);
    run_test("test");
  end
  initial apb_if.pclk=0;
  always #20 apb_if.pclk=~apb_if.pclk;
  
endmodule