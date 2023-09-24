package org.galapagos.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AuthVO {
	
	// MemberVO : AuthVO = 1:1 (Left Join)
	private String username;
	private String auth;
}
