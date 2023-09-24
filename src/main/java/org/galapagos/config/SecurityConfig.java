package org.galapagos.config;

import javax.sql.DataSource;

import org.galapagos.security.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import lombok.extern.log4j.Log4j;

@Configuration
@EnableWebSecurity
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	// RootConfig의 DataSource
	@Autowired
	private DataSource dataSource;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		// 문자 필터 추가
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		// csrf필터 앞에 문자 필터 추가
		http.addFilterBefore(filter, CsrfFilter.class);
		
		http.csrf().ignoringAntMatchers("/api/**"); // /api/로 오는 요청은 csrf 체크 무시
		
		http.authorizeRequests() // 요청에 대해 접근 권한 설정
		
			// 로그인 한 사용자만 접근(마이페이지)
			.antMatchers("/security/profile").authenticated()
			.antMatchers("/board/register", "/board/modify", "/board/remove").authenticated()
			.antMatchers("/travel/register", "/travel/modify", "/travel/remove").access("hasRole('ROLE_MANAGER')");
			

		http.formLogin() // login form에 대한 설정
			.loginPage("/security/login?error=login_required") // get / 로그인 되어 있지 않을 때 error
			.loginProcessingUrl("/security/login") // post
			.defaultSuccessUrl("/")
			.failureUrl("/security/login?error=true"); // el:param.error로 접근
		
		http.logout()
			.logoutUrl("/security/logout") // post방식(로그아웃 호출 url) = csrf 토큰 필요
			.invalidateHttpSession(true)
			.deleteCookies("remember-me", "JSESSION-ID") // 삭제할 쿠키 목록
			.logoutSuccessUrl("/security/login"); // 로그아웃 후 이동할 페이지
		
		http.rememberMe() // remember-me 기능 설정
			.key("galapagos")
			.tokenRepository(persistentTokenRepository())
			.tokenValiditySeconds(7*24*60*60); // 7일 동안 로그인 유지
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		
		auth
			.userDetailsService(customUserService())
			.passwordEncoder(passwordEncoder());
	}
	
	// password 암호화
	@Bean
	public PasswordEncoder passwordEncoder() {
		
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public UserDetailsService customUserService() {
		
		return new CustomUserDetailsService();
	}
	
	@Bean
	public PersistentTokenRepository persistentTokenRepository() {
		
		JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
		repo.setDataSource(dataSource);
		
		return repo;
	}

}

/*

비밀번호 찾기 불가능 이유
- DB에 암호화 되어 저장 되기 때문에 알 수 없음
  -> 단방향 함수인 hash함수를 사용하기 때문

*/
