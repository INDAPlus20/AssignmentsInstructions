import java.io.*;
import java.net.*;
 
class Server
{
   public static void main(String argv[]) throws Exception{
            System.out.println(" Server is Running  " );
            
            // Starts the server, waits for connection.
            ServerSocket mysocket = new ServerSocket(5555);
 
            while(true)
            {
                  // When mysocket detects a connection it binds it to connectionsocket.
                  // This is our connection.
                  Socket connectionSocket = mysocket.accept();
                  
                  //Reader sees if there is input from the client
                  BufferedReader reader = new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
                  //Writer sends output back to the client
                  BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(connectionSocket.getOutputStream()));
      
                  writer.write("*** Welcome to the Calculation Server (Addition Only) ***\r\n");            
                  writer.write("*** Please type in the first number and press Enter : \n");
                  writer.flush();
                  //Waits for reader to detects input from the client and binds it to data1
                  String data1 = reader.readLine().trim();
                  
                  // Same as above
                  writer.write("*** Please type in the second number and press Enter : \n");
                  writer.flush();
                  String data2 = reader.readLine().trim();
      
                  int num1=Integer.parseInt(data1);
                  int num2=Integer.parseInt(data2);
      
                  int result=num1+num2;            
                  System.out.println("Addition operation done " );
                  
                  //Sends result back to client
                  writer.write("\r\n=== Result is  : "+result);
                  writer.flush();
                  //Closes the connection to the client and opens a new one
                  connectionSocket.close();
            }
      }
}