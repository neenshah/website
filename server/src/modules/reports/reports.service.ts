import { Injectable } from '@nestjs/common';
import { CreateReportDto, ReportDto } from 'src/@common/dto/report/report.dto';
import { UsersRepoService } from '../repo/users-repo.service';

@Injectable()
export class ReportsService {
    constructor(private readonly userRepo: UsersRepoService) {}

    async insert(reportCreateObj: CreateReportDto): Promise<ReportDto> {
        return;
    }
}
