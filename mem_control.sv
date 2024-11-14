module mem_control (
    input logic rw, clk, key, rst, //RW = 0 -> read, RW = 1 -> write
    output logic  [2:0] out_addr,
    output logic full, empty
);
//Initialize both pointers to 0
logic [3:0] read_ptr = 4'b0000;
logic [3:0] write_ptr = 4'b0000;
//
typedef enum logic [2:0] {IDLE, READ_CHECK, WRITE_CHECK, READ, WRITE} State;
State presentState = IDLE;
State nextState;

always @(negedge clk, posedge rst)begin
	if (rst) begin
        read_ptr <= 4'b0000; 
        write_ptr <= 4'b0000;
    end
    full <= ((read_ptr[3] != write_ptr[3]) && (read_ptr[2:0] === write_ptr[2:0]));
	empty <= ((read_ptr === 4'b0000) && (write_ptr === 4'b0000) || ((read_ptr === 4'b1000) && (write_ptr === 4'b1000)));
    case (presentState)
        IDLE:
            begin
                if ( (!rw) && (key) ) begin// Key pressed and rw set to read
                    nextState <= READ_CHECK;
                    read_ptr <= read_ptr; write_ptr <= write_ptr;
                end else if (rw & key) begin //Key pressed and rw set to write
                    nextState <= WRITE_CHECK;
                    read_ptr <= read_ptr; write_ptr <= write_ptr;
                end else begin //If no input stay at Idle
                    nextState <= IDLE; 
                    read_ptr <= read_ptr; write_ptr <= write_ptr;
                end
                read_ptr <= read_ptr; write_ptr <= write_ptr;  
            end
        READ_CHECK:
            begin
                if (empty === 1'b1) begin //Check if empty
                    nextState <= IDLE;
                    read_ptr <= read_ptr; write_ptr <= write_ptr;
                end else begin //If not empty
                    nextState <= READ;
                    read_ptr <= read_ptr; write_ptr <= write_ptr;
                end
                read_ptr <= read_ptr; write_ptr <= write_ptr;
            end 
        READ:
            begin
                nextState <= IDLE;
                read_ptr <= read_ptr + 4'b0001; write_ptr <= write_ptr;
            end
        WRITE_CHECK:
            begin
                if (full === 1'b1) begin //Check if full
                    nextState <= IDLE;
                    read_ptr <= read_ptr; write_ptr <= write_ptr;
                end else begin //If not full 
                    nextState <= WRITE;
                    read_ptr <= read_ptr; write_ptr <= write_ptr;
                end
                read_ptr <= read_ptr; write_ptr <= write_ptr;
            end
        WRITE:
            begin
                nextState <= IDLE;
                read_ptr <= read_ptr; write_ptr <= write_ptr + 4'b001;
            end

        default:
        begin
            nextState <= IDLE; 
            read_ptr <= read_ptr; write_ptr <= write_ptr;
        end  
    endcase
end

always_comb begin
    
    if (rw) begin
        out_addr <= write_ptr[2:0];
    end else begin
        out_addr <= read_ptr[2:0];
    end
end

always_ff @(posedge clk) begin
    presentState <= nextState;
end
endmodule