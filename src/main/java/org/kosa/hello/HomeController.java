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
		return "변경 Hello World... " + request.getLocalPort() + " : " + request.getServerPort() ;
	}
}

/*
 * 1. 개발자 pc에서 진행하는 절차 
 *    1. git commit
 *    2. git push 
 * 2. 운영에서 진행하는 절차 
 *    1. git pull
 *    2. ./gradlew bootJar
 *    3. docker build -t 계정명/이미지명:latest . 
 *    4. docker push 계정명/이미지명:latest
 *    5. docker-compose down 
 *    6. docker-compose pull(생략 가능)
 *    7. docker-compose up -d 
 *    
 */

