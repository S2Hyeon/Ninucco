package co.ninuc.ninucco.api.dto.response;

import co.ninuc.ninucco.api.dto.EloRankingListInfo;
import co.ninuc.ninucco.api.dto.Res;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class EloRankingRes implements Res {
    List<EloRankingListInfo> eloRanking;
}
