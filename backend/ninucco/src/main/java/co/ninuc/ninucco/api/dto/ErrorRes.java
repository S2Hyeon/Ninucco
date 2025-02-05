package co.ninuc.ninucco.api.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum ErrorRes implements Res{

    // 400 BAD_REQUEST 잘못된 요청
    BAD_REQUEST("N001"),

    // 401 Unauthorized 미승인(회원도, 비회원도 아님)
    UNAUTHORIZED_MEMBER("N002"),

    // 403 Forbidden 접근 권한 없음(회원이 아님)
    ACCESS_DENIED_MEMBER("N003"),

    // 404 NOT_FOUND 잘못된 리소스 접근
    NOT_FOUND_BATTLE("N101"),
    NOT_FOUND_BETTING("N102"),
    NOT_FOUND_ITEM("N103"),
    NOT_FOUND_MEMBER("N104"),
    NOT_FOUND_MEMBER_FRIEND("N105"),

    // 409 CONFLICT 중복된 리소스
    CONFLICT_BETTING("N201"),
    CONFLICT_MEMBER("N202"),
    CONFLICT_NICKNAME("N203"),
    CONFLICT_FRIEND("N204"),

    //500 INTERNAL SERVER ERROR
    INTERNAL_SERVER_ERROR("N301"),
    INTERNAL_SERVER_ERROR_FROM_STABILITY_AI("N302"),
    INTERNAL_SERVER_ERROR_FROM_SIMILARITY_MODEL("N303"),
    INTERNAL_SERVER_ERROR_4("N304"),
    INTERNAL_SERVER_ERROR_5("N305"),
    INTERNAL_SERVER_ERROR_6("N306"),
    INTERNAL_SERVER_ERROR_FILE_NOT_PICTURE("N307"),

    // CUSTOM ERROR
    NOT_PROCEEDING_BATTLE("N401"),
    NOT_ENOUGH_POINT("N402");

    private final String code;

}
