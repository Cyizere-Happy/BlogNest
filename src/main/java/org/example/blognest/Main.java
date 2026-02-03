package org.example.blognest;

import java.io.File;
import org.apache.catalina.startup.Tomcat;

public class Main {
    public static void main(String[] args) throws Exception {
        int port = Integer.parseInt(System.getenv().getOrDefault("PORT", "8080"));
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(port);
        tomcat.getConnector();

        // In Docker, we deploy from /app/webapp
        String webappDirLocation = "/app/webapp";
        tomcat.addWebapp("", new File(webappDirLocation).getAbsolutePath());

        System.out.println("Server started at http://localhost:" + port);
        tomcat.start();
        tomcat.getServer().await();
    }
}
