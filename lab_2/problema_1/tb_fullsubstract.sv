module tb_fullsubstract;

  logic a, b, cin;
  logic r, cout;


  fullsubstract uut (
    .a(a),
    .b(b),
    .cin(cin),
    .r(r),
    .cout(cout)
  );


  initial begin
  
    $display("a b cin | cout r");
 
    a = 0; b = 0; cin = 0;
    #10;
    $display("%b %b %b  | %b %b", a, b, cin, cout, r);


    a = 0; b = 0; cin = 1;
    #10;
    $display("%b %b %b  | %b %b", a, b, cin, cout, r);


    a = 0; b = 1; cin = 0;
    #10;
    $display("%b %b %b  | %b %b", a, b, cin, cout, r);

    a = 0; b = 1; cin = 1;
    #10;
    $display("%b %b %b  | %b %b", a, b, cin, cout, r);

    a = 1; b = 0; cin = 0;
    #10;
    $display("%b %b %b  | %b %b", a, b, cin, cout, r);

    a = 1; b = 0; cin = 1;
    #10;
    $display("%b %b %b  | %b %b", a, b, cin, cout, r);

    a = 1; b = 1; cin = 0;
    #10;
    $display("%b %b %b  | %b %b", a, b, cin, cout, r);

    a = 1; b = 1; cin = 1;
    #10;
    $display("%b %b %b  | %b %b", a, b, cin, cout, r);

  end

endmodule
