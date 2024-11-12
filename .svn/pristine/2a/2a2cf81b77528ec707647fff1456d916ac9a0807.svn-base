package kr.co.amonsoft.config.security;

public enum RoleType {
    EMPLOYEE("03", "ROLE_EMPLOYEE"),
    ADMIN("02", "ROLE_ADMIN"),
    SUPERADMIN("01","ROLE_SUPERADMIN");

    private final String code;
    private final String roleName;

    RoleType(String code, String roleName) {
        this.code = code;
        this.roleName = roleName;
    }

    public String getCode() {
        return code;
    }

    public String getRoleName() {
        return roleName;
    }

    public static String getRoleNameByCode(String code) {
        for (RoleType role : values()) {
            if (role.getCode().equals(code)) {
                return role.getRoleName();
            }
        }
        return null;
    }

}
