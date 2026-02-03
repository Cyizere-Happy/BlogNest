package org.example.blognest;

import org.apache.catalina.startup.Tomcat;
import java.io.File;

public class Main {
    public static void main(String[] args) throws Exception {
        int port = Integer.parseInt(System.getenv().getOrDefault("PORT", "8080"));

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(port);
        tomcat.getConnector();

        String webappDirLocation = "src/main/webapp/";
        tomcat.addWebapp("", new File(webappDirLocation).getAbsolutePath());

        System.out.println("Server started at http://localhost:" + port);
        tomcat.start();
        tomcat.getServer().await();
    }
}
