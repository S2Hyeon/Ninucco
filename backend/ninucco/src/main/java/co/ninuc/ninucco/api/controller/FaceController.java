package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.SimilarityResult;
import co.ninuc.ninucco.api.dto.response.SimilarityResultRes;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/face")
@RequiredArgsConstructor
public class FaceController {
    private final boolean SUCCESS = true;
    @ApiOperation(value = "얼굴인식 결과 조회", notes="배틀 리스트를 조회합니다.")
    @GetMapping("/dummy")
    public ResponseEntity<?> dummyResult() {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, SimilarityResultRes.builder()
                        .imgUrl("https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/1.png")
                        .resultTitle("1퍼센트의 오차도 허용하지 않는 깐깐한 고양이상")
                        .resultDescription("장인은 대담하면서도 현실적인 성격으로, 모든 종류의 도구를 자유자재로 다루는 성격 유형입니다. \n" +
                                "\n" +
                                "내향형의 사람들은 소수의 사람들과 깊고 의미 있는 관계를 맺는 일을 선호하며, 차분한 환경을 원할 때가 많습니다.\n" +
                                "\n" +
                                "관찰형의 사람들은 실용적이고 현실적인 성격을 지니고 있습니다. 이들은 현재 발생하고 있거나 발생할 가능성이 매우 높은 일에 집중하는 경향이 있습니다.\n" +
                                "\n" +
                                "사고형의 사람들은 객관성과 합리성을 중시하며 논리에 집중하느라 감정을 간과할 때가 많습니다. 이들은 사회적 조화보다는 효율성이 더 중요하다고 생각하는 경향이 있습니다.")
                        .resultPercentages(new ArrayList<>(List.of(new SimilarityResult[]{
                                SimilarityResult.builder().title("고양이상").value(0.6).build(),
                                SimilarityResult.builder().title("강아지상").value(0.2).build()
                        }))).build())
        );
    }
}
