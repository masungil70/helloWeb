package org.kosa.hello;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.ServletRequest;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class HomeController {
	
	@GetMapping("/")
	public String index(ServletRequest request) {
		log.info("local port = {} : {}", request.getLocalPort(), request.getServerPort());
		return "666. CICD 반영됨 green으로 변경함 Hello World... " + request.getLocalPort() + " : " + request.getServerPort() + "\r\n";
	}
}

/*
 * 1. 개발자 pc에서 진행하는 절차 
 *    1. git commit
 *    2. git push
 *     
 * 2. 개발서버에서 진행하는 절차 (빌드 서버)
 *    1. git pull
 *    2. ./gradlew bootJar
 *    3. docker build -t 계정명/이미지명:latest . 
 *    4. docker push 계정명/이미지명:latest
 *    
 * 3. 운영서버에서 진행 하는 절차   
 *    1. docker-compose down 
 *    2. docker-compose pull 
 *    3. docker-compose up -d 
 *    
 */

