import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import { Report, Prisma } from '@prisma/client';

@Injectable()
export class ReportRepoService {
    constructor(private prisma: PrismaService) {}

    /**
     * @summary Insert report into database
     * @returns New DB record ID
     */
    async insert(input: Prisma.ReportCreateInput): Promise<Report> {
        return await this.prisma.report.create({
            data: input
        });
    }
}
