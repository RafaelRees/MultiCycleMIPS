library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port ( OP 			: in  STD_LOGIC_VECTOR (5 downto 0);
           RegDst 		: out  STD_LOGIC;
           MemToReg 	: out  STD_LOGIC;
           RegWrite 	: out  STD_LOGIC;
           MemRead		: out  STD_LOGIC;
           MemWrite 	: out  STD_LOGIC;
		   PCWriteCond	: out  STD_LOGIC;
		   PCWrite		: out  STD_LOGIC;
		   IorD			: out  STD_LOGIC;
		   IRWrite		: out  STD_LOGIC;
		   ALUop 		: out  STD_LOGIC_VECTOR (1 downto 0);
		   PCSource		: out  STD_LOGIC_VECTOR (1 downto 0);
           ALUSrcB		: out  STD_LOGIC_VECTOR (1 downto 0);
           ALUSrcA 		: out  STD_LOGIC;
           CLK 			: in  STD_LOGIC);
end control_unit;

architecture Behavioral of control_unit is

signal currentState : STD_LOGIC_VECTOR(3 downto 0);
 
begin
 
process(OP, currentState, CLK)
 
begin
 
if rising_edge(CLK) then
        if currentState = "0000" then
        currentState <= "0001";
        elsif currentState = "0001" then
            --if load // store
            if OP = "100011" or OP = "101011" then
            currentState <= "0010";
            --if add // sub // and // or
            elsif OP = "000000" then
            currentState <= "0110";
            --if beq
            elsif OP = "000100" then
            currentState <= "1000";
            --if addi
            elsif OP = "001000" then
            currentState <= "1010";
            end if;
        elsif currentState = "0010" then
            --if lw
            if OP = "100011" then
            currentState <= "0011";
            else
            currentState <= "0101";
            end if;
        elsif currentState = "1010" then
            currentState <= "1011";
        elsif currentState = "1011" then
            currentState <= "0000";
        elsif currentState = "0011" then
            currentState <= "0100";
        elsif currentState = "0100" then
            currentState <= "0000";
        elsif currentState = "0101" then
            currentState <= "0000";
        elsif currentState = "0110" then
            currentState <= "0111";
        elsif currentState = "0111" then
            currentState <= "0000";
        elsif currentState = "1000" then
            currentState <="0000";
        end if;
end if;
--instruction fetch (0)     
if currentState = "0000" then
        PCWrite <= '1';
        PCWriteCond <= '0';
        IorD <= '0';
        MemRead <= '1';
        MemWrite <= '0';
        IRWrite <= '1';
        MemtoReg <='0';
        PCSource <="00";
        ALUOp <="00";
        ALUSrcB <= "01";
        ALUSrcA <='0';
        RegWrite <='0';
        RegDst <= '0';
--decode/register fetch (1)
elsif currentState = "0001" then
        PCWrite <= '0';
        PCWriteCond <= '0';
        IorD <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        IRWrite <= '0';
        MemtoReg <='0';
        PCSource <="00";
        ALUOp <="00";
        ALUSrcB <= "11";
        ALUSrcA <='0';
        RegWrite <='0';
        RegDst <= '0';
--lw/sw execute (2)
elsif currentState = "0010" then
        PCWrite <= '0';
        PCWriteCond <= '0';
        IorD <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        IRWrite <= '0';
        MemtoReg <='0';
        PCSource <="00";
        ALUOp <="00";
        ALUSrcB <= "10";
        ALUSrcA <='1';
        RegWrite <='0';
        RegDst <= '0';
--lw memory access (3)
elsif currentState = "0011" then
        PCWrite <= '0';
        PCWriteCond <= '0';
        IorD <= '1';
        MemRead <= '1';
        MemWrite <= '0';
        IRWrite <= '0';
        MemtoReg <='0';
        PCSource <="00";
        ALUOp <="00";
        ALUSrcB <= "00";
        ALUSrcA <='0';
        RegWrite <='0';
        RegDst <= '0';
--lw write back (4)
elsif currentState = "0100" then
        PCWrite <= '0';
        PCWriteCond <= '0';
        IorD <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        IRWrite <= '0';
        MemtoReg <='1';
        PCSource <="00";
        ALUOp <="00";
        ALUSrcB <= "00";
        ALUSrcA <='0';
        RegWrite <='1';
        RegDst <= '0';
--sw write back (5)
elsif currentState = "0101" then
        PCWrite <= '0';
        PCWriteCond <= '0';
        IorD <= '1';
        MemRead <= '0';
        MemWrite <= '1';
        IRWrite <= '0';
        MemtoReg <='0';
        PCSource <="00";
        ALUOp <="00";
        ALUSrcB <= "00";
        ALUSrcA <='0';
        RegWrite <='0';
        RegDst <= '0';
--R-type execution (6)
elsif currentState = "0110" then
        PCWrite <= '0';
        PCWriteCond <= '0';
        IorD <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        IRWrite <= '0';
        MemtoReg <='0';
        PCSource <="00";
        ALUOp <="10";
        ALUSrcB <= "00";
        ALUSrcA <='1';
        RegWrite <='0';
        RegDst <= '0';
--R-type completion (7)
elsif currentState = "0111" then
        PCWrite <= '0';
        PCWriteCond <= '0';
        IorD <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        IRWrite <= '0';
        MemtoReg <='0';
        PCSource <="00";
        ALUOp <="00";
        ALUSrcB <= "00";
        ALUSrcA <='0';
        RegWrite <='1';
        RegDst <= '1';
--BEQ Completion (8)
elsif currentState = "1000" then
        PCWrite <= '0';
        PCWriteCond <= '1';
        IorD <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        IRWrite <= '0';
        MemtoReg <='0';
        PCSource <="01";
        ALUOp <="01";
        ALUSrcB <= "00";
        ALUSrcA <='1';
        RegWrite <='0';
        RegDst <= '0';
--J Completion (9)
elsif currentState = "1001" then
        PCWrite <= '1';
        PCWriteCond <= '0';
        IorD <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        IRWrite <= '0';
        MemtoReg <='0';
        PCSource <="10";
        ALUOp <="00";
        ALUSrcB <= "00";
        ALUSrcA <='0';
        RegWrite <='0';
        RegDst <= '0';
--addi execute
elsif currentState = "1010" then
        PCWrite <= '0';
        PCWriteCond <= '0';
        IorD <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        IRWrite <= '0';
        MemtoReg <='0';
        PCSource <="10";
        ALUOp <="00";
        ALUSrcB <= "10";
        ALUSrcA <='1';
        RegWrite <='0';
        RegDst <= '0';
--addi write back
elsif currentState = "1011" then
        PCWrite <= '0';
        PCWriteCond <= '0';
        IorD <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        IRWrite <= '0';
        MemtoReg <='0';
        PCSource <="00";
        ALUOp <="00";
        ALUSrcB <= "00";
        ALUSrcA <='0';
        RegWrite <='1';
        RegDst <= '0';
    end if;
end process;
 
end Behavioral;

