package com.jiawa.train.business.controller.admin;

import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.resp.CommonResp;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.business.resp.StationQueryResp;
import com.jiawa.train.business.req.StationQueryReq;
import com.jiawa.train.business.req.StationSaveReq;
import com.jiawa.train.business.service.StationService;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/admin/station")
public class StationAdminController {
    @Resource
    private StationService stationService;

    @PostMapping("/save")
    public CommonResp<Long> save(@Valid @RequestBody StationSaveReq req) {
        Long id = stationService.save(req);
        return new CommonResp<Long>(id);
    }

    @DeleteMapping("/delete/{id}")
    public CommonResp delete(@PathVariable Long id) {
        CommonResp<Object> resp = new CommonResp<>();
        resp.setSuccess(stationService.delete(id) != 0);
        return resp;
    }

    @GetMapping("/query-list")
    public CommonResp<PageResp<StationQueryResp>> queryList(@Valid StationQueryReq req) {
        PageResp<StationQueryResp> stations = stationService.queryList(req);
        return new CommonResp<>(stations);
    }

    @GetMapping("query-all")
    public CommonResp<List<StationQueryResp>> queryAll() {
        List<StationQueryResp> list = stationService.queryAll();
        return new CommonResp<List<StationQueryResp>>(list);
    }

}
